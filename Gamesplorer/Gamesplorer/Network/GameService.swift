//
//  GameService.swift
//  Gamesplorer
//
//  Created by Mert Ozseven on 24.05.2024.
//

import Foundation

protocol GameServiceProtocol {
    func fetchGames(page: Int, completion: @escaping(Result<GameResponse, NetworkError>) -> Void)
    func fetchNextPage(nextPageURL: String, completion: @escaping(Result<GameResponse, NetworkError>) -> Void)
}

extension API: GameServiceProtocol {
    
    func fetchGames(page: Int, completion: @escaping (Result<GameResponse, NetworkError>) -> Void) {
        executeRequestFor(router: .games(page: page), completion: completion)
    }
    
    func fetchNextPage(nextPageURL: String, completion: @escaping (Result<GameResponse, NetworkError>) -> Void) {
        guard let url = URL(string: nextPageURL) else {
            completion(.failure(.invalidRequest))
            return
        }
        
        var request = URLRequest(url: url)
        request.httpMethod = RequestMethod.get.rawValue
        
        service.execute(urlRequest: request, completion: completion)
    }
}

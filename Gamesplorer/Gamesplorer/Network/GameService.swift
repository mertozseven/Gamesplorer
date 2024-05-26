//
//  GameService.swift
//  Gamesplorer
//
//  Created by Mert Ozseven on 24.05.2024.
//

import Foundation

protocol GameServiceProtocol {
    func fetchGames(page: Int, completion: @escaping (Result<GameResponse, NetworkError>) -> Void)
    func searchGames(query: String, page: Int, completion: @escaping (Result<GameResponse, NetworkError>) -> Void)
    func fetchGameDetails(id: Int, completion: @escaping (Result<GameDetailResponse, NetworkError>) -> Void)
}

extension API: GameServiceProtocol {
    
    func fetchGames(page: Int, completion: @escaping (Result<GameResponse, NetworkError>) -> Void) {
        executeRequestFor(router: .games(page: page), completion: completion)
    }
    
    func searchGames(query: String, page: Int, completion: @escaping (Result<GameResponse, NetworkError>) -> Void) {
        executeRequestFor(router: .search(query: query, page: page), completion: completion)
    }
    
    func fetchGameDetails(id: Int, completion: @escaping (Result<GameDetailResponse, NetworkError>) -> Void) {
        executeRequestFor(router: .gameDetails(id: id), completion: completion)
    }
    
}

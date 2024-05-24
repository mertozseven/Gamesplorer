//
//  GameService.swift
//  Gamesplorer
//
//  Created by Mert Ozseven on 24.05.2024.
//

import Foundation

protocol GameServiceProtocol {
    func fetchGames(page: Int, completion: @escaping(Result<GameResponse, NetworkError>) -> Void)
}

extension API: GameServiceProtocol {
    
    func fetchGames(page: Int, completion: @escaping (Result<GameResponse, NetworkError>) -> Void) {
        executeRequestFor(router: .games(page: page), completion: completion)
    }
    
}

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
    func fetchGenres(completion: @escaping (Result<GenreResponse, NetworkError>) -> Void)
    func fetchGameDetails(id: Int, completion: @escaping (Result<Game, NetworkError>) -> Void)
}

extension API: GameServiceProtocol {
    
    func fetchGames(page: Int, completion: @escaping (Result<GameResponse, NetworkError>) -> Void) {
        executeRequestFor(router: .games(page: page), completion: completion)
    }
    
    func searchGames(query: String, page: Int, completion: @escaping (Result<GameResponse, NetworkError>) -> Void) {
        executeRequestFor(router: .search(query: query, page: page), completion: completion)
    }
    
    func fetchGenres(completion: @escaping (Result<GenreResponse, NetworkError>) -> Void) {
        executeRequestFor(router: .genres, completion: completion)
    }
    
    func fetchGameDetails(id: Int, completion: @escaping (Result<Game, NetworkError>) -> Void) {
        executeRequestFor(router: .gameDetails(id: id), completion: completion)
    }
}

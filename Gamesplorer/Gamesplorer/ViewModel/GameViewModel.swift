//
//  GameViewModel.swift
//  Gamesplorer
//
//  Created by Mert Ozseven on 20.05.2024.
//

import Foundation

final class GameViewModel {
    
    private(set) var games: [Game] = []
    private var apiManager: GameServiceProtocol
    private var nextPageURL: String?
    
    init(apiManager: GameServiceProtocol = API.shared) {
        self.apiManager = apiManager
    }
    
    func fetchGames(page: Int = 1, completion: @escaping () -> Void) {
        apiManager.fetchGames(page: page) { [weak self] result in
            guard let self = self else { return }
            switch result {
            case .success(let gameResponse):
                if page == 1 {
                    self.games = gameResponse.results
                } else {
                    self.games.append(contentsOf: gameResponse.results)
                }
                self.nextPageURL = gameResponse.next
                completion()
            case .failure(let error):
                print(error.localizedDescription)
                completion()
            }
        }
    }
    
    func fetchNextPage(completion: @escaping () -> Void) {
        guard let nextPageURL = nextPageURL else {
            completion()
            return
        }
        
        apiManager.fetchNextPage(nextPageURL: nextPageURL) { [weak self] result in
            guard let self = self else { return }
            switch result {
            case .success(let gameResponse):
                self.games.append(contentsOf: gameResponse.results)
                self.nextPageURL = gameResponse.next
                completion()
            case .failure(let error):
                print(error.localizedDescription)
                completion()
            }
        }
    }
}

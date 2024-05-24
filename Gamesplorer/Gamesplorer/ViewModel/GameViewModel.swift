//
//  GameViewModel.swift
//  Gamesplorer
//
//  Created by Mert Ozseven on 20.05.2024.
//

import Foundation

protocol GameViewModelDelegate: AnyObject {
    func reloadData()
    func showError()
}

protocol GameViewModelProtocol {
    var delegate: GameViewModelDelegate? { get set }
    func loadGames(page: Int)
    func game(at index: IndexPath) -> Game?
}

final class GameViewModel {
    
    let service: GameServiceProtocol
    private(set) var games: [Game]? = []
    
    private var nextPageURL: String?
    weak var delegate: GameViewModelDelegate?
    
    init(service: GameServiceProtocol = API.shared) {
        self.service = service
    }
    
    fileprivate func fetchGames(page: Int = 1) {
        service.fetchGames(page: page) { [weak self] result in
            guard let self = self else { return }
            switch result {
            case .success(let gameResponse):
                if page == 1 {
                    self.games = gameResponse.results
                } else {
                    self.games?.append(contentsOf: gameResponse.results)
                }
                self.nextPageURL = gameResponse.next
                DispatchQueue.main.async {
                    self.delegate?.reloadData()
                }
            case .failure(let error):
                print(error.localizedDescription)
                DispatchQueue.main.async {
                    self.delegate?.showError()
                }
            }
        }
    }
    
}

extension GameViewModel: GameViewModelProtocol {
    
    func loadGames(page: Int = 1) {
        fetchGames(page: page)
    }
    
    func game(at index: IndexPath) -> Game? {
        guard index.row < games.count else { return nil }
        return games[index.row]
    }
    
}

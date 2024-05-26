//
//  GameViewModel.swift
//  Gamesplorer
//
//  Created by Mert Ozseven on 20.05.2024.
//

import Foundation

protocol GameViewModelDelegate: AnyObject {
    func reloadGameData()
    func showError()
}

protocol GameViewModelProtocol {
    var delegate: GameViewModelDelegate? { get set }
    func loadGames(page: Int)
    func loadMoreGames()
    func game(at index: IndexPath) -> Game?
    func searchGames(query: String, page: Int)
    func loadMoreSearchResults()
    func searchResult(at index: IndexPath) -> Game?
}

final class GameViewModel: GameViewModelProtocol {
    
    let service: GameServiceProtocol
    private(set) var games: [Game]? = []
    private var currentPage: Int = 1
    private var isFetching: Bool = false
    private var hasMoreGames: Bool = true
    private(set) var searchResults: [Game]? = []
    private var searchCurrentPage: Int = 1
    private var isSearching: Bool = false
    private var hasMoreSearchResults: Bool = true
    
    weak var delegate: GameViewModelDelegate?
    
    init(service: GameServiceProtocol = API.shared) {
        self.service = service
    }
    
    fileprivate func fetchGames(page: Int = 1) {
        guard !isFetching && hasMoreGames else { return }
        isFetching = true
        service.fetchGames(page: page) { [weak self] result in
            guard let self = self else { return }
            self.isFetching = false
            switch result {
            case .success(let gameResponse):
                if page == 1 {
                    self.games = gameResponse.results
                } else {
                    self.games!.append(contentsOf: gameResponse.results!)
                }
                self.hasMoreGames = gameResponse.next != nil
                self.currentPage = page
                DispatchQueue.main.async {
                    self.delegate?.reloadGameData()
                }
            case .failure(let error):
                print(error.localizedDescription)
                DispatchQueue.main.async {
                    self.delegate?.showError()
                }
            }
        }
    }
    
    fileprivate func fetchSearchResults(query: String, page: Int = 1) {
        guard !isSearching && hasMoreSearchResults else { return }
        isSearching = true
        service.searchGames(query: query, page: page) { [weak self] result in
            guard let self = self else { return }
            self.isSearching = false
            switch result {
            case .success(let gameResponse):
                if page == 1 {
                    self.searchResults = gameResponse.results
                } else {
                    self.searchResults?.append(contentsOf: gameResponse.results!)
                }
                self.hasMoreSearchResults = gameResponse.next != nil
                self.searchCurrentPage = page
                DispatchQueue.main.async {
                    self.delegate?.reloadGameData()
                }
            case .failure(let error):
                print(error.localizedDescription)
                DispatchQueue.main.async {
                    self.delegate?.showError()
                }
            }
        }
    }
    
    func loadGames(page: Int = 1) {
        fetchGames(page: page)
    }
    
    func loadMoreGames() {
        fetchGames(page: currentPage + 1)
    }
    
    func game(at index: IndexPath) -> Game? {
        guard index.row < games?.count ?? 0 else { return nil }
        return games?[index.row]
    }
    
    func searchGames(query: String, page: Int = 1) {
        fetchSearchResults(query: query, page: page)
    }
    
    func loadMoreSearchResults() {
        fetchSearchResults(query: "", page: searchCurrentPage + 1)
    }
    
    func searchResult(at index: IndexPath) -> Game? {
        guard index.row < searchResults?.count ?? 0 else { return nil }
        return searchResults?[index.row]
    }
    
}

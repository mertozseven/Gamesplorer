//
//  GenreViewModel.swift
//  Gamesplorer
//
//  Created by Mert Ozseven on 25.05.2024.
//

import Foundation

protocol GenreViewModelDelegate: AnyObject {
    func reloadGenreData()
}

protocol GenreViewModelProtocol {
    var delegate: GenreViewModelDelegate? { get set }
    func loadGenres()
    func genre(at index: IndexPath) -> Genre?
}

final class GenreViewModel: GenreViewModelProtocol {
    
    let service: GameServiceProtocol
    private(set) var genres: [Genre]? = []
    
    weak var delegate: GenreViewModelDelegate?
    
    init(service: GameServiceProtocol = API.shared) {
        self.service = service
    }
    
    fileprivate func fetchGenres() {
        service.fetchGenres { [weak self] result in
            guard let self = self else { return }
            switch result {
            case .success(let genreResponse):
                self.genres = genreResponse.results
                DispatchQueue.main.async {
                    self.delegate?.reloadGenreData()
                }
            case .failure(let error):
                print(error.localizedDescription)
            }
        }
    }
    
    func loadGenres() {
        fetchGenres()
    }
    
    func genre(at index: IndexPath) -> Genre? {
        guard index.row < genres?.count ?? 0 else { return nil }
        return genres?[index.row]
    }
}

//
//  GameDetailViewModel.swift
//  Gamesplorer
//
//  Created by Mert Ozseven on 26.05.2024.
//

import Foundation

protocol GameDetailViewModelDelegate: AnyObject {
    func didUpdateGameDetail()
    func didFailWithError(_ error: NetworkError)
}

protocol GameDetailViewModelProtocol {
    var delegate: GameDetailViewModelDelegate? { get set }
    var gameDetail: GameDetailResponse? { get }
    func fetchGameDetails(id: Int)
}

final class GameDetailViewModel: GameDetailViewModelProtocol {
    
    weak var delegate: GameDetailViewModelDelegate?
    private let service: GameServiceProtocol
    var gameDetail: GameDetailResponse?
    
    init(service: GameServiceProtocol = API.shared) {
        self.service = service
    }
    
    func fetchGameDetails(id: Int) {
        service.fetchGameDetails(id: id) { [weak self] result in
            switch result {
            case .success(let details):
                print("Game Details Fetched Successfully: \(details)")
                DispatchQueue.main.async {
                    self?.gameDetail = details
                    self?.delegate?.didUpdateGameDetail()
                }
            case .failure(let error):
                print("Failed to fetch game details: \(error.localizedDescription)")
                DispatchQueue.main.async {
                    self?.delegate?.didFailWithError(error)
                }
            }
        }
    }
    
}

//
//  FavoritesViewController.swift
//  Gamesplorer
//
//  Created by Mert Ozseven on 19.05.2024.
//

import UIKit

final class FavoritesViewController: UIViewController {
    
    // MARK: - Properties
    private var favoriteGames: [GameDetailViewModel?] = []
    
    // MARK: - UI Components
    private let emptyView = GPLabel(
        text: "No favorites added yet",
        textAlignment: .center,
        textColor: .label,
        font: .preferredFont(forTextStyle: .title3)
    )
    
    // MARK: - Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        configureView()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        loadFavoriteGames()
    }
    
    // MARK: - Inits
    init(viewModel: [GameDetailViewModel?]) {
        self.favoriteGames = viewModel
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Private Methods
    private func configureView() {
        addViews()
        configureLayout()
        emptyView.isHidden = true

        view.backgroundColor = .systemBackground
    }
    
    private func addViews() {
        view.addSubview(emptyView)
    }
    
    private func configureLayout() {
        emptyView.setupAnchors(
            top: view.safeAreaLayoutGuide.topAnchor,
            bottom: view.safeAreaLayoutGuide.bottomAnchor,
            leading: view.leadingAnchor,
            trailing: view.trailingAnchor
        )
    }
    
    private func loadFavoriteGames() {
        let defaults = UserDefaults.standard
        let favoriteIDs = defaults.dictionaryRepresentation().keys.filter { $0.starts(with: "favorite_") }
            .compactMap { Int($0.replacingOccurrences(of: "favorite_", with: "")) }
        
        favoriteGames = favoriteIDs.map { id -> GameDetailViewModel? in
            let viewModel = GameDetailViewModel(service: API.shared)
            viewModel.fetchGameDetails(id: id)
            return viewModel
        }
        updateUI()
    }

    private func updateUI() {
        if favoriteGames.isEmpty {
            emptyView.isHidden = false
        } else {
            emptyView.isHidden = true
        }
    }
    
}

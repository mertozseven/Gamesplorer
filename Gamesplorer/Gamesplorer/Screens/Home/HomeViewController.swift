//
//  HomeViewController.swift
//  Gamesplorer
//
//  Created by Mert Ozseven on 18.05.2024.
//

import UIKit

final class HomeViewController: UIViewController {
    
    // MARK: - UI Components
    private let topView = GPTopView()
    
    private var pageViewController: GamePageViewController!
    
    private lazy var gamesListCollectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.minimumInteritemSpacing = 0
        layout.minimumLineSpacing = 0
        layout.scrollDirection = .vertical
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collectionView.register(GamesCell.self, forCellWithReuseIdentifier: GamesCell.identifier)
        collectionView.isScrollEnabled = false
        collectionView.dataSource = self
        collectionView.delegate = self
        collectionView.backgroundColor = .clear
        collectionView.isUserInteractionEnabled = true
        
        return collectionView
    }()
    
    // MARK: - Properties
    private var viewModel: GameViewModel!
    
    // MARK: - Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        configureView()
        viewModel.loadGames(page: 2)
    }
    
    // MARK: - Inits
    init(viewModel: GameViewModel) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
        self.viewModel.delegate = self
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Private Methods
    private func configureView() {
        addViews()
        configureLayout()
        reloadData()
        view.backgroundColor = .systemBackground
        navigationController?.setNavigationBarHidden(true, animated: false)
    }
    
    private func addViews() {
        view.addSubview(topView)
    }
    
    private func configureLayout() {
        topView.setupAnchors(
            top: view.safeAreaLayoutGuide.topAnchor,
            paddingTop: 16,
            leading: view.leadingAnchor,
            paddingLeading: 16,
            trailing: view.trailingAnchor,
            paddingTrailing: 16,
            height: 68
        )
    }
    
    private func configurePageVC() {
        pageViewController = GamePageViewController(viewModel: viewModel)
        addChild(pageViewController)
        view.addSubview(pageViewController.view)
        pageViewController.didMove(toParent: self)
        
        pageViewController.view.setupAnchors(
            top: topView.bottomAnchor,
            paddingTop: 16,
            leading: view.leadingAnchor,
            trailing: view.trailingAnchor,
            height: 256
        )
    }
    
    private func showErrorAlert() {
        let alert = UIAlertController(title: "Error", message: "Please try again", preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "Reload", style: .default, handler: { _ in
            self.viewModel.loadGames(page: 1)
        }))
        present(alert, animated: true, completion: nil)
    }
    
}

// MARK: - GameViewModelDelegate
extension HomeViewController: GameViewModelDelegate {
    
    func reloadData() {
        configurePageVC()
    }
    
    func showError() {
        showErrorAlert()
    }
    
}

// MARK: - UICollectionViewDelegate
extension HomeViewController: UICollectionViewDelegate {
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        guard let selectedGame = viewModel.games?[indexPath.row] else { return }
        // TODO: - Send game to detailvc
    }
    
}

// MARK: - UICollectionViewDataSource
extension HomeViewController: UICollectionViewDataSource {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        viewModel.games?.count ?? 0
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: GamesCell.identifier, for: indexPath) as? GamesCell else {
            return UICollectionViewCell()
        }
        // TODO: - Cell configuration
        return cell
    }
    
}

// MARK: - UICollectionViewDelegateFlowLayout
extension HomeViewController: UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let screenWidth = UIScreen.main.bounds.width - 32
        return CGSize(width: screenWidth, height: 128)
    }
    
}

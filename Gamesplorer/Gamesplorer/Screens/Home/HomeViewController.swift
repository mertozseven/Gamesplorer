//
//  HomeViewController.swift
//  Gamesplorer
//
//  Created by Mert Ozseven on 18.05.2024.
//

import UIKit

final class HomeViewController: UIViewController {
    
    // MARK: - Properties
    private var viewModel: GameViewModel!
    private var gameDetailViewModel: GameDetailViewModel?
    private let collectionViewHeight: CGFloat = 20 * 88
    
    // MARK: - UI Components
    private let scrollView = UIScrollView()
    private let contentView = UIView()
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
        collectionView.backgroundColor = .secondarySystemBackground
        collectionView.isUserInteractionEnabled = true
        collectionView.layer.cornerRadius = 10
        
        return collectionView
    }()
    
    // MARK: - Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        viewModel.loadGames(page: 2)
        configureView()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        navigationController?.setNavigationBarHidden(true, animated: false)
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
        view.backgroundColor = .systemBackground
        addViews()
        configurePageVC()
        configureLayout()
        reloadGameData()
    }
    
    private func addViews() {
        view.addSubview(scrollView)
        scrollView.addSubview(contentView)
        contentView.addSubview(topView)
        contentView.addSubview(gamesListCollectionView)
    }
    
    private func configureLayout() {
        scrollView.setupAnchors(
            top: view.topAnchor,
            bottom: view.bottomAnchor,
            leading: view.leadingAnchor,
            trailing: view.trailingAnchor
        )
        
        contentView.setupAnchors(
            top: scrollView.topAnchor,
            bottom: scrollView.bottomAnchor,
            leading: scrollView.leadingAnchor,
            trailing: scrollView.trailingAnchor
        )
        contentView.widthAnchor.constraint(equalTo: scrollView.widthAnchor).isActive = true
        contentView.heightAnchor.constraint(greaterThanOrEqualTo: scrollView.heightAnchor).isActive = true
        contentView.bottomAnchor.constraint(equalTo: gamesListCollectionView.bottomAnchor, constant: 16).isActive = true
        
        topView.setupAnchors(
            top: contentView.topAnchor,
            paddingTop: 16,
            leading: contentView.leadingAnchor,
            paddingLeading: 16,
            trailing: contentView.trailingAnchor,
            paddingTrailing: 16,
            height: 68
        )
        
        gamesListCollectionView.setupAnchors(
            top: pageViewController.view.bottomAnchor,
            paddingTop: 16,
            leading: contentView.leadingAnchor,
            paddingLeading: 16,
            trailing: contentView.trailingAnchor,
            paddingTrailing: 16,
            height: collectionViewHeight
        )
    }
    
    private func configurePageVC() {
        if pageViewController == nil {
            pageViewController = GamePageViewController(viewModel: viewModel)
            addChild(pageViewController)
            contentView.addSubview(pageViewController.view)
            pageViewController.didMove(toParent: self)
            
            pageViewController.view.translatesAutoresizingMaskIntoConstraints = false
            NSLayoutConstraint.activate([
                pageViewController.view.topAnchor.constraint(equalTo: topView.bottomAnchor, constant: 16),
                pageViewController.view.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
                pageViewController.view.trailingAnchor.constraint(equalTo: contentView.trailingAnchor),
                pageViewController.view.heightAnchor.constraint(equalToConstant: 256)
            ])
        }
        
        pageViewController.setupViewControllers()
    }
    
    private func showErrorAlert() {
        let alert = UIAlertController(title: "Error", message: "Please try again", preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "Reload", style: .default, handler: { _ in
            self.viewModel.loadGames(page: 2)
        }))
        present(alert, animated: true, completion: nil)
    }
}

// MARK: - GameViewModelDelegate
extension HomeViewController: GameViewModelDelegate {
    
    func reloadGameData() {
        DispatchQueue.main.async {
            self.configurePageVC()
            self.gamesListCollectionView.reloadData()
        }
    }
    
    func showError() {
        DispatchQueue.main.async {
            self.showErrorAlert()
        }
    }
}

// MARK: - UICollectionViewDelegate
extension HomeViewController: UICollectionViewDelegate {
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        guard let selectedGame = viewModel.game(at: indexPath) else { return }
        let detailViewModel = gameDetailViewModel ?? GameDetailViewModel(service: API.shared)
        let detailVC = DetailViewController(gameID: selectedGame.id ?? 3482, viewModel: detailViewModel, screenshots: selectedGame.short_screenshots)
        navigationController?.pushViewController(detailVC, animated: true)
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
        if let game = viewModel.game(at: indexPath) {
            cell.configure(with: game)
        }
        return cell
    }
}

// MARK: - UICollectionViewDelegateFlowLayout
extension HomeViewController: UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let screenWidth = UIScreen.main.bounds.width - 32
        return CGSize(width: screenWidth, height: 88)
    }
    
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        let offsetY = scrollView.contentOffset.y
        let contentHeight = scrollView.contentSize.height
        if offsetY > contentHeight - scrollView.frame.height - 100 {
            viewModel.loadMoreGames()
        }
    }
}

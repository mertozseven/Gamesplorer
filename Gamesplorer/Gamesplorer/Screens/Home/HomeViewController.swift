//
//  HomeViewController.swift
//  Gamesplorer
//
//  Created by Mert Ozseven on 18.05.2024.
//

import UIKit

final class HomeViewController: BaseViewController {
    
    // MARK: - UI Components
    private let topView = GPTopView()
    
    private var pageViewController: GamePageViewController!
    
    // MARK: - Properties
    private var viewModel: GameViewModel!
    
    // MARK: - Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        configureView()
        viewModel.loadGames(page: 1)
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
            paddingLeading: 8,
            trailing: view.trailingAnchor,
            paddingTrailing: 8,
            height: 256
        )
    }
    
}
// MARK: - GameViewModelDelegate
extension HomeViewController: GameViewModelDelegate {
    
    func showLoadingView() {
        
    }
    
    func hideLoadingView() {
        
    }
    
    func reloadData() {
        configurePageVC()
    }
}

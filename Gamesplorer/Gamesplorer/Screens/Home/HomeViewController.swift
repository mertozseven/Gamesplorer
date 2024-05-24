//
//  HomeViewController.swift
//  Gamesplorer
//
//  Created by Mert Ozseven on 18.05.2024.
//

import UIKit

protocol HomeViewControllerProtocol {
    
}

final class HomeViewController: BaseViewController {
    
    // MARK: - UI Components
    private let topView = GPTopView()
    
    // MARK: - Properties
    private var viewModel: GameViewModel!

    // MARK: - Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        configureView()
    }
    
    // MARK: - Inits
    init(viewModel: GameViewModel) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Private Methods
    private func configureView() {
        addViews()
        configureLayout()
        
        view.backgroundColor = .systemBackground
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
            height: 64
        )
    }
    
}

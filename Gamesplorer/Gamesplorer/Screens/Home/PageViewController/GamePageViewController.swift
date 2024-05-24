//
//  GamePageViewController.swift
//  Gamesplorer
//
//  Created by Mert Ozseven on 24.05.2024.
//

import UIKit

final class GamePageViewController: UIPageViewController {
    
    // MARK: - Properties
    private var viewModel: GameViewModel!
    private var viewControllersList: [UIViewController] = []
    
    // MARK: - Inits
    init(viewModel: GameViewModel) {
        self.viewModel = viewModel
        super.init(transitionStyle: .scroll, navigationOrientation: .horizontal, options: nil)
        self.dataSource = self
        self.delegate = self
        setupViewControllers()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Private Methods
    private func setupViewControllers() {
        let games = viewModel.games.shuffled().prefix(5)
        viewControllersList = games.map { game in
            PagePreviewViewController(imageURL: game.background_image ?? "")
        }
        
        if let firstVC = viewControllersList.first {
            setViewControllers([firstVC], direction: .forward, animated: true, completion: nil)
        }
    }
    
}

extension GamePageViewController: UIPageViewControllerDataSource, UIPageViewControllerDelegate {
    func pageViewController(_ pageViewController: UIPageViewController, viewControllerBefore viewController: UIViewController) -> UIViewController? {
        guard let index = viewControllersList.firstIndex(of: viewController), index > 0 else {
            return nil
        }
        return viewControllersList[index - 1]
    }
    
    func pageViewController(_ pageViewController: UIPageViewController, viewControllerAfter viewController: UIViewController) -> UIViewController? {
        guard let index = viewControllersList.firstIndex(of: viewController), index < viewControllersList.count - 1 else {
            return nil
        }
        return viewControllersList[index + 1]
    }
}

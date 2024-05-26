//
//  GamePageViewController.swift
//  Gamesplorer
//
//  Created by Mert Ozseven on 24.05.2024.
//

import UIKit

protocol GamePageViewControllerDelegate: AnyObject {
    func didSelectGame(_ game: Game)
}

final class GamePageViewController: UIPageViewController {

    // MARK: - Properties
    private var viewModel: GameViewModel!
    private var viewControllersList: [UIViewController] = []
    private var timer: Timer?
    private var currentIndex: Int = 0
    weak var pageDelegate: GamePageViewControllerDelegate?

    // MARK: - Initialization
    init(viewModel: GameViewModel) {
        self.viewModel = viewModel
        super.init(transitionStyle: .scroll, navigationOrientation: .horizontal, options: nil)
        self.dataSource = self
        self.delegate = self
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    deinit {
        timer?.invalidate()
    }

    // MARK: - Lifecycle Methods
    override func viewDidLoad() {
        super.viewDidLoad()
        setupViewControllers()
        startTimer()
    }

    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        startTimer()
    }

    override func viewDidDisappear(_ animated: Bool) {
        super.viewDidDisappear(animated)
        stopTimer()
    }

    // MARK: - Configuration of View Controllers
    func setupViewControllers() {
        guard let games = viewModel.games, !games.isEmpty else { return }
        let shuffledGames = games.shuffled().prefix(5)
        viewControllersList = shuffledGames.map { PagePreviewViewController(game: $0, delegate: self) }

        if let firstVC = viewControllersList.first {
            setViewControllers([firstVC], direction: .forward, animated: true, completion: nil)
        }
    }

    // MARK: - Private Methods
    private func startTimer() {
        timer?.invalidate()
        timer = Timer.scheduledTimer(timeInterval: 3.0, target: self, selector: #selector(moveToNextPage), userInfo: nil, repeats: true)
    }

    private func stopTimer() {
        timer?.invalidate()
        timer = nil
    }

    // MARK: - Objective Methods
    @objc private func moveToNextPage() {
        guard !viewControllersList.isEmpty, timer != nil else { return }
        let nextIndex = (currentIndex + 1) % viewControllersList.count
        let direction: UIPageViewController.NavigationDirection = nextIndex < currentIndex ? .reverse : .forward
        let nextVC = viewControllersList[nextIndex]
        setViewControllers([nextVC], direction: direction, animated: true) { [weak self] completed in
            if completed {
                self?.currentIndex = nextIndex
            }
        }
    }
}

// MARK: - UIPageViewControllerDataSource Methods
extension GamePageViewController: UIPageViewControllerDataSource {
    
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

// MARK: - UIPageViewControllerDelegate Methods
extension GamePageViewController: UIPageViewControllerDelegate {
    
    func pageViewController(_ pageViewController: UIPageViewController, didFinishAnimating finished: Bool, previousViewControllers: [UIViewController], transitionCompleted completed: Bool) {
        if completed {
            stopTimer()
            DispatchQueue.main.asyncAfter(deadline: .now() + 8) { [weak self] in
                self?.startTimer()
            }
        }
    }
    
    func pageViewController(_ pageViewController: UIPageViewController, willTransitionTo pendingViewControllers: [UIViewController]) {
        if let pendingVC = pendingViewControllers.first as? PagePreviewViewController {
            self.currentIndex = viewControllersList.firstIndex(of: pendingVC) ?? 0
        }
    }
}

// MARK: - PagePreviewViewControllerDelegate
extension GamePageViewController: PagePreviewViewControllerDelegate {
    func didSelectGame(_ game: Game) {
        pageDelegate?.didSelectGame(game)
    }
}

import UIKit

final class GamePageViewController: UIPageViewController {

    // MARK: - Properties
    private var viewModel: GameViewModel!
    private var viewControllersList: [UIViewController] = []
    private var timer: Timer?
    private var currentIndex: Int = 0

    // MARK: - Inits
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

    // MARK: - Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        setupViewControllers()
        startTimer()
    }

    override func viewDidDisappear(_ animated: Bool) {
        super.viewDidDisappear(animated)
        timer?.invalidate()
    }

    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        startTimer()
    }

    // MARK: - Private Methods
    private func setupViewControllers() {
        let games = viewModel.games?.shuffled().prefix(5)
        viewControllersList = games.map { game in
            let viewController = PagePreviewViewController(game: game)
            return viewController
        } as! [UIViewController]
        
        if let firstVC = viewControllersList.first {
            setViewControllers([firstVC], direction: .forward, animated: true, completion: nil)
        }
    }

    private func startTimer() {
        timer?.invalidate()
        timer = Timer.scheduledTimer(timeInterval: 3.0, target: self, selector: #selector(moveToNextPage), userInfo: nil, repeats: true)
    }

    // MARK: - Objective
    @objc private func moveToNextPage() {
        guard !viewControllersList.isEmpty else { return }
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

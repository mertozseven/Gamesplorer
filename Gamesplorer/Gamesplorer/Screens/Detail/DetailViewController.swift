//
//  DetailViewController.swift
//  Gamesplorer
//
//  Created by Mert Ozseven on 25.05.2024.
//

import UIKit

class DetailViewController: UIViewController {
    
    // MARK: - Properties
    private var detailViewModel: GameDetailViewModel!
    private var screenshots: [Screenshots]!
    private var gameID: Int
    private var isExpanded = false
    
    private var isFavorite: Bool = false {
        didSet {
            let imageName = isFavorite ? "star.fill" : "star"
            saveButton.setImage(UIImage(systemName: imageName), for: .normal)
        }
    }
    
    // MARK: - UI Components
    private let scrollView: UIScrollView = {
        let scrollView = UIScrollView()
        scrollView.contentInsetAdjustmentBehavior = .never
        
        return scrollView
    }()
    
    private let contentView = UIView()
    
    private let backButton: UIButton = {
        let button = UIButton()
        button.setImage(UIImage(systemName: "chevron.left"), for: .normal)
        button.tintColor = .label
        button.backgroundColor = .secondarySystemBackground
        button.layer.cornerRadius = 14
        
        return button
    }()
    
    private let saveButton: UIButton = {
        let button = UIButton()
        button.setImage(UIImage(systemName: "star"), for: .normal)
        button.tintColor = .label
        button.backgroundColor = .secondarySystemBackground
        button.layer.cornerRadius = 14
        
        return button
    }()
    
    private let backgroundImageView = GPImageView(
        contentMode: .scaleAspectFill,
        clipsToBounds: true
    )
    
    private let gameImageView = GPImageView(
        contentMode: .scaleAspectFill,
        clipsToBounds: true,
        cornerRadius: 10/57 * 128
    )
    
    private let gameTitle = GPLabel(
        text: "",
        textAlignment: .left,
        textColor: .label,
        font: .systemFont(ofSize: 24, weight: .heavy),
        numberOfLines: 0,
        adjustsFontSizeToFitWidth: true
    )
    
    private let developersTitle = GPLabel(
        text: "",
        textAlignment: .left,
        textColor: .secondaryLabel,
        font: .systemFont(ofSize: 14, weight: .heavy),
        numberOfLines: 0,
        adjustsFontSizeToFitWidth: true
    )
    
    private let topSeparatorView: UIView = {
        let view = UIView()
        view.backgroundColor = .systemGray5
        view.layer.cornerRadius = 0.5
        return view
    }()
    
    private let metacriticTitle = GPLabel(
        text: "Metacritic",
        textAlignment: .center,
        textColor: .tertiaryLabel,
        font: .systemFont(ofSize: 16, weight: .heavy),
        adjustsFontSizeToFitWidth: true
    )
    
    private let metacriticScore = GPLabel(
        text: "",
        textAlignment: .center,
        textColor: .secondaryLabel,
        font: .systemFont(ofSize: 18, weight: .heavy)
    )
    
    private let verticalSeparatorView: UIView = {
        let view = UIView()
        view.backgroundColor = .systemGray5
        view.layer.cornerRadius = 0.5
        return view
    }()
    
    private let releaseDateTitle = GPLabel(
        text: "Release Date",
        textAlignment: .center,
        textColor: .tertiaryLabel,
        font: .systemFont(ofSize: 16, weight: .heavy)
    )
    
    private let releaseDate = GPLabel(
        text: "",
        textAlignment: .center,
        textColor: .secondaryLabel,
        font: .systemFont(ofSize: 18, weight: .heavy),
        adjustsFontSizeToFitWidth: true
    )
    
    private let bodySeparatorView: UIView = {
        let view = UIView()
        view.backgroundColor = .systemGray5
        view.layer.cornerRadius = 0.5
        
        return view
    }()
    
    private let descriptionTitle = GPLabel(
        text: "Description",
        textAlignment: .left,
        textColor: .label,
        font: .systemFont(ofSize: 21, weight: .heavy)
    )
    
    private let descriptionBody = GPLabel(
        text: "",
        textAlignment: .left,
        textColor: .label,
        font: .preferredFont(forTextStyle: .body),
        numberOfLines: 3
    )
    
    private let seeMoreButton = UIButton(type: .system)
    
    private lazy var descriptionStackView: UIStackView = {
        let stackView = UIStackView(arrangedSubviews: [descriptionTitle, descriptionBody, seeMoreButton])
        stackView.axis = .vertical
        stackView.spacing = 8
        stackView.alignment = .fill
        stackView.distribution = .fill
        
        return stackView
    }()
    
    private let previewSeparatorView: UIView = {
        let view = UIView()
        view.backgroundColor = .systemGray5
        view.layer.cornerRadius = 0.5
        
        return view
    }()
    
    private let previewTitle = GPLabel(
        text: "Preview",
        textAlignment: .left,
        textColor: .label,
        font: .systemFont(ofSize: 21, weight: .heavy)
    )
    
    private lazy var gamesListCollectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.minimumInteritemSpacing = 0
        layout.minimumLineSpacing = 0
        layout.scrollDirection = .horizontal
        let screenWidth = UIScreen.main.bounds.width - 32
        layout.estimatedItemSize = CGSize(width: screenWidth, height: 174)
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collectionView.register(ScreenshotsCell.self, forCellWithReuseIdentifier: ScreenshotsCell.identifier)
        collectionView.dataSource = self
        collectionView.backgroundColor = .clear
        collectionView.contentInsetAdjustmentBehavior = .always
        collectionView.showsHorizontalScrollIndicator = false
        collectionView.isUserInteractionEnabled = true
        
        return collectionView
    }()
    
    // MARK: - Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        detailViewModel.fetchGameDetails(id: gameID)
        configureView()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        navigationController?.setNavigationBarHidden(true, animated: false)
    }
    
    // MARK: - Inits
    init(gameID: Int, viewModel: GameDetailViewModel, screenshots: [Screenshots]) {
        self.gameID = gameID
        self.detailViewModel = viewModel
        self.screenshots = screenshots
        super.init(nibName: nil, bundle: nil)
        self.detailViewModel.delegate = self
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Private Methods
    private func configureView() {
        addViews()
        configureLayout()
        configureBackButton()
        configureSeeMoreButton()
        checkFavoriteStatus()
        configureSaveButton()
        view.backgroundColor = .systemBackground
    }
    
    private func addViews() {
        view.addSubview(scrollView)
        scrollView.addSubview(contentView)
        contentView.addSubview(backgroundImageView)
        view.addSubview(backButton)
        view.addSubview(saveButton)
        contentView.addSubview(gameImageView)
        contentView.addSubview(gameTitle)
        contentView.addSubview(developersTitle)
        contentView.addSubview(topSeparatorView)
        contentView.addSubview(descriptionStackView)
        contentView.addSubview(previewSeparatorView)
        contentView.addSubview(previewTitle)
        contentView.addSubview(gamesListCollectionView)
        contentView.addSubview(bodySeparatorView)
        contentView.addSubview(metacriticTitle)
        contentView.addSubview(metacriticScore)
        contentView.addSubview(verticalSeparatorView)
        contentView.addSubview(releaseDateTitle)
        contentView.addSubview(releaseDate)
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
        contentView.bottomAnchor.constraint(equalTo: gamesListCollectionView.bottomAnchor, constant: 96).isActive = true
        
        backgroundImageView.setupAnchors(
            top: contentView.topAnchor,
            leading: contentView.leadingAnchor,
            trailing: contentView.trailingAnchor,
            height: 240
        )
        backButton.setupAnchors(
            top: view.safeAreaLayoutGuide.topAnchor,
            paddingTop: 8,
            leading: view.leadingAnchor,
            paddingLeading: 16,
            width: 28,
            height: 28
        )
        saveButton.setupAnchors(
            top: view.safeAreaLayoutGuide.topAnchor,
            paddingTop: 8,
            trailing: view.trailingAnchor,
            paddingTrailing: 8,
            width: 28,
            height: 28
        )
        gameImageView.setupAnchors(
            top: backgroundImageView.bottomAnchor,
            paddingTop: 16,
            leading: contentView.leadingAnchor,
            paddingLeading: 16,
            width: 128,
            height: 128
        )
        gameTitle.setupAnchors(
            top: gameImageView.topAnchor,
            paddingTop: -4,
            leading: gameImageView.trailingAnchor,
            paddingLeading: 16,
            trailing: contentView.trailingAnchor,
            paddingTrailing: 16,
            height: 104
        )
        developersTitle.setupAnchors(
            top: gameTitle.bottomAnchor,
            leading: gameTitle.leadingAnchor,
            trailing: gameTitle.trailingAnchor,
            height: 34
        )
        topSeparatorView.setupAnchors(
            top: gameImageView.bottomAnchor,
            paddingTop: 16,
            leading: gameImageView.leadingAnchor,
            trailing: contentView.trailingAnchor,
            height: 1
        )
        metacriticTitle.setupAnchors(
            top: topSeparatorView.bottomAnchor,
            paddingTop: 16,
            leading: contentView.leadingAnchor,
            trailing: verticalSeparatorView.leadingAnchor,
            height: 18
        )
        metacriticScore.setupAnchors(
            top: metacriticTitle.bottomAnchor,
            paddingTop: 8,
            leading: metacriticTitle.leadingAnchor,
            trailing: metacriticTitle.trailingAnchor,
            height: 20
        )
        verticalSeparatorView.setupAnchors(
            top: metacriticTitle.topAnchor,
            bottom: metacriticScore.bottomAnchor,
            centerX: contentView.centerXAnchor,
            width: 1
        )
        releaseDateTitle.setupAnchors(
            top: topSeparatorView.bottomAnchor,
            paddingTop: 16,
            leading: verticalSeparatorView.trailingAnchor,
            trailing: contentView.trailingAnchor,
            height: 18
        )
        releaseDate.setupAnchors(
            top: releaseDateTitle.bottomAnchor,
            paddingTop: 8,
            leading: releaseDateTitle.leadingAnchor,
            trailing: releaseDateTitle.trailingAnchor,
            height: 20
        )
        bodySeparatorView.setupAnchors(
            top: metacriticScore.bottomAnchor,
            paddingTop: 16,
            leading: descriptionStackView.leadingAnchor,
            trailing: descriptionStackView.trailingAnchor,
            height: 1
        )
        
        descriptionStackView.setupAnchors(
            top: bodySeparatorView.bottomAnchor,
            paddingTop: 16,
            leading: contentView.leadingAnchor,
            paddingLeading: 16,
            trailing: contentView.trailingAnchor,
            paddingTrailing: 16
        )
        previewSeparatorView.setupAnchors(
            top: descriptionStackView.bottomAnchor,
            paddingTop: 16,
            leading: descriptionStackView.leadingAnchor,
            trailing: descriptionStackView.trailingAnchor,
            height: 1
        )
        previewTitle.setupAnchors(
            top: previewSeparatorView.bottomAnchor,
            paddingTop: 16,
            leading: contentView.leadingAnchor,
            paddingLeading: 16,
            trailing: contentView.trailingAnchor,
            height: 24
        )
        gamesListCollectionView.setupAnchors(
            top: previewTitle.bottomAnchor,
            paddingTop: 16,
            leading: contentView.leadingAnchor,
            trailing: contentView.trailingAnchor,
            height: 174
        )
    }
    
    private func configureBackButton() {
        backButton.addTarget(self, action: #selector(backButtonAction), for: .touchUpInside)
    }
    
    private func configureSaveButton() {
        saveButton.addTarget(self, action: #selector(toggleFavorite), for: .touchUpInside)
    }
    
    private func checkFavoriteStatus() {
        isFavorite = UserDefaults.standard.bool(forKey: "favorite_\(gameID)")
    }
    
    private func updateFavorites() {
        let key = "favorite_\(gameID)"
        if isFavorite {
            UserDefaults.standard.set(true, forKey: key)
        } else {
            UserDefaults.standard.removeObject(forKey: key)
        }
    }
    
    private func showErrorAlert() {
        let alert = UIAlertController(title: "Error", message: "Please try again", preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "Reload", style: .default, handler: { _ in
            self.detailViewModel.fetchGameDetails(id: self.gameID)
        }))
        present(alert, animated: true, completion: nil)
    }
    
    private func configureData() {
        guard let gameDetail = self.detailViewModel.gameDetail else { return }
        DispatchQueue.main.async {
            self.backgroundImageView.loadImage(from: gameDetail.backgroundImageAdditional)
            self.gameImageView.loadImage(from: gameDetail.backgroundImage)
            self.gameTitle.text = gameDetail.name
            let developers = gameDetail.developers?.first?.name ?? "N/A"
            self.developersTitle.text = "Developer: \(developers)"
            self.descriptionBody.text = gameDetail.descriptionRaw
            self.metacriticScore.text = "\(gameDetail.metacritic ?? 0)"
            if let releaseDateString = gameDetail.released {
                self.releaseDate.text = releaseDateString.formattedDate()
            } else {
                self.releaseDate.text = "Unknown"
            }
        }
    }
    
    private func configureSeeMoreButton() {
        seeMoreButton.setTitle("See More", for: .normal)
        seeMoreButton.addTarget(self, action: #selector(seeMoreButtonTapped), for: .touchUpInside)
    }
    
    // MARK: - Objective Methods
    @objc private func backButtonAction() {
        navigationController?.popViewController(animated: true)
    }
    
    @objc private func seeMoreButtonTapped() {
        isExpanded.toggle()
        descriptionBody.numberOfLines = isExpanded ? 0 : 3
        seeMoreButton.setTitle(isExpanded ? "See Less" : "See More", for: .normal)
        UIView.animate(withDuration: 0.3) {
            self.view.layoutIfNeeded()
        }
    }
    
    @objc private func toggleFavorite() {
        isFavorite.toggle()
        updateFavorites()
        detailViewModel.toggleFavorite()
    }
}

// MARK: - GameDetailViewModelDelegate
extension DetailViewController: GameDetailViewModelDelegate {
    
    func didUpdateFavorites(_ isFavorited: Bool) {
        isFavorite = isFavorited
    }
    
    func didUpdateGameDetail() {
        configureData()
    }
    
    func didFailWithError(_ error: NetworkError) {
        DispatchQueue.main.async {
            self.showErrorAlert()
        }
    }
}

// MARK: - UICollectionViewDataSource
extension DetailViewController: UICollectionViewDataSource {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        screenshots.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: ScreenshotsCell.identifier, for: indexPath) as? ScreenshotsCell else {
            return UICollectionViewCell()
        }
        cell.configure(with: screenshots[indexPath.row])
        return cell
    }
    
}

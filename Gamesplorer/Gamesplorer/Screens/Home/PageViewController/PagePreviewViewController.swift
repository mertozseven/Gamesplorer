//
//  PagePreviewViewController.swift
//  Gamesplorer
//
//  Created by Mert Ozseven on 24.05.2024.
//

import UIKit
import Kingfisher

protocol PagePreviewViewControllerDelegate: AnyObject {
    func didSelectGame(_ game: Game)
}

final class PagePreviewViewController: UIViewController {
    
    // MARK: - Properties
    private var game: Game
    weak var delegate: PagePreviewViewControllerDelegate?
    
    // MARK: - UI Components
    private let imageView = GPImageView(
        contentMode: .scaleAspectFill,
        clipsToBounds: true,
        cornerRadius: 10
    )
    
    private let gameTitle = GPLabel(
        text: "",
        textAlignment: .left,
        textColor: .white,
        font: .systemFont(ofSize: 21, weight: .bold),
        numberOfLines: 0,
        adjustsFontSizeToFitWidth: true
    )
    
    private let metacriticLogo = GPImageView(
        image: UIImage(named: "metacritic.png")!.resized(to: CGSize(width: 24, height: 24)),
        contentMode: .scaleAspectFit,
        backgroundColor: .clear
    )
    
    private let metacriticScore = GPLabel(
        text: "",
        textAlignment: .left,
        textColor: .white,
        font: .systemFont(ofSize: 21, weight: .bold)
    )
    
    private let releaseDate = GPLabel(
        text: "",
        textAlignment: .center,
        textColor: .systemBlue,
        font: .preferredFont(forTextStyle: .headline),
        backgroundColor: .systemGray5,
        clipsToBounds: true,
        cornerRadius: 12
    )
    
    private let gradientLayer = CAGradientLayer()
    
    // MARK: - Inits
    init(game: Game, delegate: PagePreviewViewControllerDelegate) {
        self.game = game
        self.delegate = delegate
        super.init(nibName: nil, bundle: nil)
        configureGesture()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        configureView()
        setupGradient()
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        gradientLayer.frame = CGRect(
            x: 0,
            y: view.bounds.height / 2,
            width: view.bounds.width,
            height: view.bounds.height / 2
        )
    }
    
    // MARK: - Private Methods
    private func configureView() {
        addViews()
        configureLayout()
        imageView.loadImage(from: game.background_image)
        gameTitle.text = game.name
        metacriticScore.text = "\(game.metacritic ?? 0)"
        if let releaseDateString = game.released {
            releaseDate.text = releaseDateString.formattedDate()
        } else {
            releaseDate.text = "Unknown"
        }
    }
    
    private func addViews() {
        view.addSubview(imageView)
        imageView.layer.addSublayer(gradientLayer)
        imageView.addSubview(gameTitle)
        imageView.addSubview(metacriticLogo)
        imageView.addSubview(metacriticScore)
        imageView.addSubview(releaseDate)
    }
    
    private func configureLayout() {
        imageView.setupAnchors(
            top: view.topAnchor,
            bottom: view.bottomAnchor,
            leading: view.leadingAnchor,
            paddingLeading: 16,
            trailing: view.trailingAnchor,
            paddingTrailing: 16
        )
        gameTitle.setupAnchors(
            bottom: imageView.bottomAnchor,
            paddingBottom: 8,
            leading: imageView.leadingAnchor,
            paddingLeading: 16,
            trailing: releaseDate.leadingAnchor,
            paddingTrailing: 8,
            height: 88
        )
        metacriticLogo.setupAnchors(
            bottom: releaseDate.topAnchor,
            paddingBottom: 16,
            trailing: metacriticScore.leadingAnchor,
            paddingTrailing: 8,
            width: 24,
            height: 24
        )
        metacriticScore.setupAnchors(
            trailing: imageView.trailingAnchor,
            paddingTrailing: 16,
            centerY: metacriticLogo.centerYAnchor,
            width: 32,
            height: 22
        )
        releaseDate.setupAnchors(
            trailing: imageView.trailingAnchor,
            paddingTrailing: 16,
            centerY: gameTitle.centerYAnchor,
            width: 160,
            height: 24
        )
    }
    
    private func setupGradient() {
        gradientLayer.colors = [
            UIColor.clear.cgColor,
            UIColor.black.cgColor,
            UIColor.black.cgColor
        ]
        gradientLayer.locations = [0.0, 1.0]
        gradientLayer.startPoint = CGPoint(x: 0.5, y: 0.0)
        gradientLayer.endPoint = CGPoint(x: 0.5, y: 1.0)
    }
    
    private func configureGesture() {
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(handleTap))
        view.addGestureRecognizer(tapGesture)
    }
    
    @objc private func handleTap() {
        delegate?.didSelectGame(game)
    }
}

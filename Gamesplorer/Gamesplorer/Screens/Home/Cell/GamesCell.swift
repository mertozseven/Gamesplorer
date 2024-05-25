//
//  GamesCell.swift
//  Gamesplorer
//
//  Created by Mert Ozseven on 24.05.2024.
//

import UIKit
import Kingfisher

class GamesCell: UICollectionViewCell {
    
    // MARK: - Properties
    static let identifier = "GamesCell"
    private var game: Game!
    
    // MARK: - UI Components
    private let gameIcon = GPImageView(
        image: UIImage(systemName: "star")?.resized(to: CGSize(width: 64, height: 64)),
        contentMode: .scaleAspectFill,
        clipsToBounds: true,
        cornerRadius: 10
    )
    
    private let gameTitle = GPLabel(
        text: "",
        textAlignment: .left,
        textColor: .label,
        font: .preferredFont(forTextStyle: .headline)
    )
    
    private let metacriticLogo = GPImageView(
        image: UIImage(named: "metacritic.png")?.resized(to: CGSize(width: 24, height: 24)),
        contentMode: .scaleAspectFit,
        backgroundColor: .clear
    )
    
    private let metacriticScore = GPLabel(
        text: "",
        textAlignment: .left,
        textColor: .label,
        font: .preferredFont(forTextStyle: .body)
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
    
    private let separatorView: UIView = {
        let view = UIView()
        view.backgroundColor = .systemGray4
        view.layer.cornerRadius = 0.5
        
        return view
    }()
    
    // MARK: - Inits
    override init(frame: CGRect) {
        super.init(frame: frame)
        configureView()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Public Methods
    public func configure(with game: Game) {
        self.game = game
        gameTitle.text = game.name
        metacriticScore.text = "\(game.metacritic ?? 0)"
        if let releaseDateString = game.released {
            releaseDate.text = releaseDateString.formattedDate()
        } else {
            releaseDate.text = "Unknown"
        }
        loadImage()
        configureView()
    }
    
    // MARK: - Private Methods
    private func configureView() {
        addViews()
        configureLayout()
    }
    
    private func addViews() {
        contentView.addSubview(gameIcon)
        contentView.addSubview(gameTitle)
        contentView.addSubview(metacriticLogo)
        contentView.addSubview(metacriticScore)
        contentView.addSubview(releaseDate)
        contentView.addSubview(separatorView)
    }
    
    private func configureLayout() {
        gameIcon.setupAnchors(
            leading: leadingAnchor,
            paddingLeading: 16,
            centerY: centerYAnchor,
            width: 64,
            height: 64
        )
        gameTitle.setupAnchors(
            top: gameIcon.topAnchor,
            bottom: metacriticLogo.topAnchor,
            paddingBottom: 8,
            leading: gameIcon.trailingAnchor,
            paddingLeading: 8,
            trailing: trailingAnchor,
            paddingTrailing: 8
        )
        metacriticLogo.setupAnchors(
            bottom: gameIcon.bottomAnchor,
            leading: gameIcon.trailingAnchor,
            paddingLeading: 8,
            width: 24,
            height: 24
        )
        metacriticScore.setupAnchors(
            leading: metacriticLogo.trailingAnchor,
            paddingLeading: 8,
            centerY: metacriticLogo.centerYAnchor,
            width: 32,
            height: 18
        )
        releaseDate.setupAnchors(
            trailing: trailingAnchor,
            paddingTrailing: 16,
            centerY: metacriticLogo.centerYAnchor,
            width: 160,
            height: 24
        )
        separatorView.setupAnchors(
            bottom: bottomAnchor,
            leading: gameIcon.trailingAnchor,
            trailing: trailingAnchor,
            paddingTrailing: 16,
            height: 1
        )
    }
    
    private func loadImage() {
        guard let url = URL(string: game.background_image ?? "") else { return }
        
        let downsampling = DownsamplingImageProcessor(size: gameIcon.bounds.size)
        let processor = downsampling
        
        gameIcon.kf.indicatorType = .activity
        gameIcon.kf.setImage(
            with: url,
            placeholder: UIImage(named: "placeholder"),
            options: [
                .processor(processor),
                .scaleFactor(UIScreen.main.scale),
                .transition(.fade(1)),
                .cacheOriginalImage
            ]
        )
    }
    
    // MARK: - Handle reuse
    override func prepareForReuse() {
        super.prepareForReuse()
        gameIcon.image = UIImage(systemName: "star")?.resized(to: CGSize(width: 56, height: 56))
        gameTitle.text = ""
        metacriticScore.text = ""
        releaseDate.text = ""
    }
}

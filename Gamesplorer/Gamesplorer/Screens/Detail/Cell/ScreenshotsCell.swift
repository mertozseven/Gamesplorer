//
//  ScreenshotsCell.swift
//  Gamesplorer
//
//  Created by Mert Ozseven on 26.05.2024.
//

import UIKit

class ScreenshotsCell: UICollectionViewCell {
    
    // MARK: - Properties
    static let identifier = "ScreenshotsCell"
    private var screenshot: Screenshots?
    
    // MARK: - UI Components
    private let screenshotImage = GPImageView(
        contentMode: .scaleAspectFill,
        clipsToBounds: true,
        cornerRadius: 10
    )
    
    // MARK: - Inits
    override init(frame: CGRect) {
        super.init(frame: frame)
        configureView()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Public Methods
    public func configure(with screenshot: Screenshots) {
        screenshotImage.loadImage(from: screenshot.image)
        configureView()
    }
    
    // MARK: - Private Methods
    private func configureView() {
        addViews()
        configureLayout()
    }
    
    private func addViews() {
        contentView.addSubview(screenshotImage)
    }
    
    private func configureLayout() {
        screenshotImage.setupAnchors(
            centerX: centerXAnchor,
            centerY: centerYAnchor,
            width: UIScreen.main.bounds.width - 48,
            height: 174
        )
    }
    
    // MARK: - Handle reuse
    override func prepareForReuse() {
        super.prepareForReuse()
        screenshotImage.image = UIImage(systemName: "star")?.resized(to: CGSize(width: 170, height: 160))
    }
    
}

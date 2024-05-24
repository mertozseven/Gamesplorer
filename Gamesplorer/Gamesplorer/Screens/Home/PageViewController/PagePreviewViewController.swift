//
//  PagePreviewViewController.swift
//  Gamesplorer
//
//  Created by Mert Ozseven on 24.05.2024.
//

import UIKit
import Kingfisher

final class PagePreviewViewController: UIViewController {
    
    // MARK: - UI Components
    private let imageView = GPImageView(
        contentMode: .scaleAspectFill,
        clipsToBounds: true,
        cornerRadius: 10
    )
    
    private let blurView = UIVisualEffectView(effect: UIBlurEffect(style: .systemThinMaterial))
    private let gradientLayer = CAGradientLayer()
    
    // MARK: - Properties
    private var imageURL: String
    
    // MARK: - Inits
    init(imageURL: String) {
        self.imageURL = imageURL
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        configureView()
        loadImage()
        setupGradient()
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
//        gradientLayer.frame = blurView.bounds
    }
    
    // MARK: - Private Methods
    private func configureView() {
        addViews()
        configureLayout()
    }
    
    private func addViews() {
        view.addSubview(imageView)
//        view.addSubview(blurView)
//        blurView.layer.addSublayer(gradientLayer)
    }
    
    private func configureLayout() {
        imageView.setupAnchors(
            top: view.topAnchor,
            bottom: view.bottomAnchor,
            leading: view.leadingAnchor,
            trailing: view.trailingAnchor
        )
        
//        blurView.setupAnchors(
//            bottom: view.bottomAnchor,
//            leading: view.leadingAnchor,
//            trailing: view.trailingAnchor,
//            height: view.bounds.height / 2
//        )
    }
    
    private func loadImage() {
        guard let url = URL(string: imageURL) else { return }
        let processor = DownsamplingImageProcessor(size: imageView.bounds.size)
        imageView.kf.setImage(
            with: url,
            options: [
                .processor(processor),
                .scaleFactor(UIScreen.main.scale),
                .transition(.fade(1)),
                .cacheOriginalImage
            ]
        )
    }
    
    private func setupGradient() {
        gradientLayer.colors = [
            UIColor.clear.cgColor,
            UIColor.black.withAlphaComponent(0.3).cgColor,
            UIColor.black.withAlphaComponent(0.6).cgColor
        ]
        gradientLayer.locations = [0.0, 0.5, 1.0]
        gradientLayer.startPoint = CGPoint(x: 0.5, y: 0.0)
        gradientLayer.endPoint = CGPoint(x: 0.5, y: 1.0)
    }
}

//
//  SplashViewController.swift
//  Gamesplorer
//
//  Created by Mert Ozseven on 26.05.2024.
//

import UIKit

class SplashViewController: UIViewController {
    
    // MARK: - UI Components
    private let welcomeLabel = GPLabel(
        text: "Welcome to \nGamesplorer",
        textAlignment: .center,
        textColor: .label,
        font: .systemFont(ofSize: 40, weight: .bold),
        numberOfLines: 0,
        adjustsFontSizeToFitWidth: false
    )
    
    private let gamepadIcon: UIImageView = {
        let imageView = UIImageView()
        imageView.image = UIImage(systemName: "gamecontroller.fill")
        imageView.tintColor = .systemYellow
        imageView.clipsToBounds = true
        imageView.contentMode = .scaleAspectFit
        
        return imageView
    }()
    
    private let gamepadTitleDescription = GPLabel(
        text: "Latest Games",
        textAlignment: .left,
        textColor: .label,
        font: .preferredFont(forTextStyle: .title2),
        numberOfLines: 0,
        adjustsFontSizeToFitWidth: false
    )
    
    private let gamepadDescription = GPLabel(
        text: "Find and latest and popular games 🎮",
        textAlignment: .left,
        textColor: .secondaryLabel,
        font: .preferredFont(forTextStyle: .body),
        numberOfLines: 0,
        adjustsFontSizeToFitWidth: false
    )
    
    private let metacriticIcon: UIImageView = {
        let imageView = UIImageView()
        imageView.image = UIImage(named: "metacritic.png")
        imageView.tintColor = .systemGreen
        imageView.clipsToBounds = true
        imageView.contentMode = .scaleAspectFit
        
        return imageView
    }()
    
    private let metacriticTitleDescription = GPLabel(
        text: "See Scores",
        textAlignment: .left,
        textColor: .label,
        font: .preferredFont(forTextStyle: .title2),
        adjustsFontSizeToFitWidth: false
    )
    
    private let metacriticDescription = GPLabel(
        text: "Is it good or is it bad? Check the metacritic scores of the most popular games 🎯",
        textAlignment: .left,
        textColor: .secondaryLabel,
        font: .preferredFont(forTextStyle: .body),
        numberOfLines: 0,
        adjustsFontSizeToFitWidth: false
    )
    
    private let devicesIcon: UIImageView = {
        let imageView = UIImageView()
        imageView.image = UIImage(systemName: "laptopcomputer.and.iphone")
        imageView.tintColor = .systemBlue
        imageView.clipsToBounds = true
        imageView.contentMode = .scaleAspectFit
        
        return imageView
    }()
    
    private let devicesTitleDescription = GPLabel(
        text: "Connect From Anywhere",
        textAlignment: .left,
        textColor: .label,
        font: .preferredFont(forTextStyle: .title2),
        adjustsFontSizeToFitWidth: true
    )
    
    private let devicesDescription = GPLabel(
        text: "Crypto Watch is available on all Apple products. Track currents market from anywhere 💻",
        textAlignment: .left,
        textColor: .secondaryLabel,
        font: .preferredFont(forTextStyle: .body),
        numberOfLines: 0,
        adjustsFontSizeToFitWidth: true
    )
    
    private let continueButton: UIButton = {
        let button = UIButton()
        button.backgroundColor = .systemBlue
        button.layer.cornerRadius = 10
        button.titleLabel?.font = .preferredFont(forTextStyle: .headline)
        button.titleLabel?.textAlignment = .center
        button.setTitle("Continue", for: .normal)
        button.setTitleColor(.white, for: .normal)
        
        return button
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureView()
    }
    
    // MARK: - Private Methods
    private func configureView() {
        addViews()
        configureLayout()
        continueButtonTapped()
        view.backgroundColor = .systemBackground
    }
    
    private func addViews() {
        view.addSubview(welcomeLabel)
        view.addSubview(gamepadIcon)
        view.addSubview(gamepadTitleDescription)
        view.addSubview(gamepadDescription)
        view.addSubview(metacriticIcon)
        view.addSubview(metacriticTitleDescription)
        view.addSubview(metacriticDescription)
        view.addSubview(devicesIcon)
        view.addSubview(devicesTitleDescription)
        view.addSubview(devicesDescription)
        view.addSubview(continueButton)
    }
    
    private func configureLayout() {
        welcomeLabel.setupAnchors(
            top: view.topAnchor,
            paddingTop: 80,
            leading: view.leadingAnchor,
            trailing: view.trailingAnchor,
            height: 96
        )
        
        gamepadIcon.setupAnchors(
            top: gamepadTitleDescription.topAnchor,
            paddingTop: 12,
            leading: view.leadingAnchor,
            paddingLeading: 40,
            width: 56,
            height: 56
        )
        
        gamepadTitleDescription.setupAnchors(
            top: welcomeLabel.bottomAnchor,
            paddingTop: 32,
            leading: gamepadIcon.trailingAnchor,
            paddingLeading: 16,
            width: UIScreen.main.bounds.width / 2,
            height: 32
        )
        
        gamepadDescription.setupAnchors(
            top: gamepadTitleDescription.bottomAnchor,
            paddingTop: 4,
            leading: gamepadIcon.trailingAnchor,
            paddingLeading: 16,
            width: UIScreen.main.bounds.width / 2 + 40,
            height: 48
        )
        
        metacriticIcon.setupAnchors(
            top: metacriticTitleDescription.topAnchor,
            paddingTop: 16,
            leading: gamepadIcon.leadingAnchor,
            width: 48,
            height: 48
        )
        
        metacriticTitleDescription.setupAnchors(
            top: gamepadDescription.bottomAnchor,
            paddingTop: 24,
            leading: gamepadTitleDescription.leadingAnchor,
            width: UIScreen.main.bounds.width / 2,
            height: 24
        )
        
        metacriticDescription.setupAnchors(
            top: metacriticTitleDescription.bottomAnchor,
            paddingTop: 2,
            leading: metacriticTitleDescription.leadingAnchor,
            width: UIScreen.main.bounds.width / 2 + 40,
            height: 72
        )
        
        devicesIcon.setupAnchors(
            top: devicesTitleDescription.topAnchor,
            paddingTop: 24,
            leading: gamepadIcon.leadingAnchor,
            width: 56,
            height: 56
        )
        
        devicesTitleDescription.setupAnchors(
            top: metacriticDescription.bottomAnchor,
            paddingTop: 24,
            leading: devicesIcon.trailingAnchor,
            paddingLeading: 16,
            width: UIScreen.main.bounds.width / 2 + 40,
            height: 28
        )
        
        devicesDescription.setupAnchors(
            top: devicesTitleDescription.bottomAnchor,
            paddingTop: 4,
            leading: devicesTitleDescription.leadingAnchor,
            width: UIScreen.main.bounds.width / 2 + 32,
            height: 72
        )
        
        continueButton.setupAnchors(
            bottom: view.bottomAnchor,
            paddingBottom: 24,
            centerX: view.centerXAnchor,
            width: UIScreen.main.bounds.width / 2 + 40,
            height: 48
        )
    }
    
    private func continueButtonTapped() {
        continueButton.addTarget(self, action: #selector(continueButtonAction), for: .touchUpInside)
    }
    
    @objc private func continueButtonAction() {
        dismiss(animated: true)
    }

}

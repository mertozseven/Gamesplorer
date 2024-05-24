import UIKit
import Kingfisher

final class PagePreviewViewController: UIViewController {
    
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
        numberOfLines: 0
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
    
    private let gradientLayer = CAGradientLayer()
    
    // MARK: - Properties
    private var game: Game
    
    // MARK: - Inits
    init(game: Game) {
        self.game = game
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
        gameTitle.text = game.name
        metacriticScore.text = "\(game.metacritic ?? 0)"
    }
    
    private func addViews() {
        view.addSubview(imageView)
        imageView.layer.addSublayer(gradientLayer)
        imageView.addSubview(gameTitle)
        imageView.addSubview(metacriticLogo)
        imageView.addSubview(metacriticScore)
    }
    
    private func configureLayout() {
        imageView.setupAnchors(
            top: view.topAnchor,
            bottom: view.bottomAnchor,
            leading: view.leadingAnchor,
            paddingLeading: 8,
            trailing: view.trailingAnchor,
            paddingTrailing: 8
        )
        gameTitle.setupAnchors(
            bottom: imageView.bottomAnchor,
            paddingBottom: 8,
            leading: imageView.leadingAnchor,
            paddingLeading: 16,
            trailing: metacriticLogo.leadingAnchor,
            paddingTrailing: 8,
            height: 80
        )
        metacriticLogo.setupAnchors(
            trailing: metacriticScore.leadingAnchor,
            paddingTrailing: 8,
            centerY: gameTitle.centerYAnchor,
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
    }
    
    private func loadImage() {
        guard let url = URL(string: game.background_image ?? "") else { return }
        
        let downsampling = DownsamplingImageProcessor(size: imageView.bounds.size)
        let processor = downsampling
        
        imageView.kf.indicatorType = .activity
        imageView.kf.setImage(
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
    
    
    private func setupGradient() {
        gradientLayer.colors = [
            UIColor.clear.cgColor,
            UIColor.black.cgColor
        ]
        gradientLayer.locations = [0.0, 1.0]
        gradientLayer.startPoint = CGPoint(x: 0.5, y: 0.0)
        gradientLayer.endPoint = CGPoint(x: 0.5, y: 1.0)
    }
    
}

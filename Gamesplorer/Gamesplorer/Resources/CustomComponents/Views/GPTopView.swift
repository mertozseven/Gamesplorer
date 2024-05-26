//
//  GPTopView.swift
//  Gamesplorer
//
//  Created by Mert Ozseven on 18.05.2024.
//

import UIKit

class GPTopView: UIView {

    // MARK: - UI Components
    private let titleLabel = GPLabel(
        text: "Gamesplorer",
        textAlignment: .left,
        textColor: .label,
        font: .systemFont(ofSize: 34, weight: .black)
    )
    
    private let dateLabel = GPLabel(
        text: "",
        textAlignment: .left,
        textColor: .secondaryLabel,
        font: .systemFont(ofSize: 24, weight: .heavy)
    )
    
    private let searchButton = GPImageView(
        image: UIImage(systemName: "magnifyingglass.circle")?.withTintColor(.systemBlue).resized(to: CGSize(width: 40, height: 40)),
        contentMode: .scaleAspectFit,
        clipsToBounds: true
    )
    
    // MARK: - Initializers
    override init(frame: CGRect) {
        super.init(frame: frame)
        configureView()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        configureView()
    }
    
    // MARK: - Public Methods
    public func configureWithCurrentDateAndGreeting() {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "E d MMM"
        let currentDate = dateFormatter.string(from: Date())
        dateLabel.text = currentDate
    }
    
    // MARK: - Private Methods
    private func configureView() {
        backgroundColor = .clear
        addViews()
        configureLayout()
        configureWithCurrentDateAndGreeting()
    }
    
    private func addViews() {
        addSubview(titleLabel)
        addSubview(dateLabel)
        addSubview(searchButton)
    }
    
    private func configureLayout() {
        titleLabel.translatesAutoresizingMaskIntoConstraints = false
        dateLabel.translatesAutoresizingMaskIntoConstraints = false
        searchButton.translatesAutoresizingMaskIntoConstraints = false
        
        let titleLabelHeightConstraint = titleLabel.heightAnchor.constraint(equalToConstant: 34)
        titleLabelHeightConstraint.priority = UILayoutPriority(999)
        titleLabelHeightConstraint.isActive = true
        
        let dateLabelHeightConstraint = dateLabel.heightAnchor.constraint(equalToConstant: 24)
        dateLabelHeightConstraint.priority = UILayoutPriority(999)
        dateLabelHeightConstraint.isActive = true

        NSLayoutConstraint.activate([
            titleLabel.topAnchor.constraint(equalTo: topAnchor),
            titleLabel.leadingAnchor.constraint(equalTo: leadingAnchor),
            titleLabel.trailingAnchor.constraint(equalTo: searchButton.leadingAnchor, constant: -8),
            
            dateLabel.topAnchor.constraint(equalTo: titleLabel.bottomAnchor),
            dateLabel.leadingAnchor.constraint(equalTo: leadingAnchor),
            dateLabel.trailingAnchor.constraint(equalTo: searchButton.leadingAnchor, constant: -8),
            dateLabel.bottomAnchor.constraint(equalTo: bottomAnchor),
            
            searchButton.trailingAnchor.constraint(equalTo: trailingAnchor),
            searchButton.centerYAnchor.constraint(equalTo: centerYAnchor),
            searchButton.widthAnchor.constraint(equalToConstant: 40),
            searchButton.heightAnchor.constraint(equalToConstant: 40)
        ])
    }

}

#Preview {
    let previewView = GPTopView()
    previewView.frame = CGRect(x: 0, y: 0, width: 375, height: 100)
    return previewView
}

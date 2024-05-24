//
//  GamesCell.swift
//  Gamesplorer
//
//  Created by Mert Ozseven on 24.05.2024.
//

import UIKit

class GamesCell: UICollectionViewCell {
    
    // MARK: - Properties
    static let identifier = "GamesCell"
    
    // MARK: - UI Components
    private let containerView: UIView = {
        let view = UIView()
        view.backgroundColor = .secondarySystemBackground
        view.layer.cornerRadius = 10
        
        return view
    }()
    
    private let gameIcon = GPImageView(
        contentMode: .scaleAspectFill,
        clipsToBounds: true,
        cornerRadius: 10
    )
    
}

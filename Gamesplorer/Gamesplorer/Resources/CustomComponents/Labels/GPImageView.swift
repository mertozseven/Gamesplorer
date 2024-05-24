//
//  GPImageView.swift
//  Gamesplorer
//
//  Created by Mert Ozseven on 18.05.2024.
//

import UIKit

class GPImageView: UIImageView {
    
    // MARK: - inits
    override init(frame: CGRect) {
        super.init(frame: frame)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    init(
        image: UIImage? = nil,
        contentMode: UIView.ContentMode = .scaleAspectFit,
        clipsToBounds: Bool = true,
        cornerRadius: CGFloat = 0,
        borderColor: UIColor = .clear,
        borderWidth: CGFloat = 0,
        backgroundColor: UIColor = .clear,
        isUserInteractionEnabled: Bool = false,
        tintColor: UIColor? = nil,
        alpha: CGFloat = 1.0
    ) {
        super.init(frame: .zero)
        self.image = image
        self.contentMode = contentMode
        self.clipsToBounds = clipsToBounds
        self.layer.cornerRadius = cornerRadius
        self.layer.borderColor = borderColor.cgColor
        self.layer.borderWidth = borderWidth
        self.backgroundColor = backgroundColor
        self.isUserInteractionEnabled = isUserInteractionEnabled
        self.tintColor = tintColor
        self.alpha = alpha
    }
    
}

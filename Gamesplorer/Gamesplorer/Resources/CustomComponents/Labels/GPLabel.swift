//
//  GPLabel.swift
//  Gamesplorer
//
//  Created by Mert Ozseven on 18.05.2024.
//

import UIKit

class GPLabel: UILabel {

    // MARK: - inits
    override init(frame: CGRect) {
        super.init(frame: frame)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    init(
        text: String,
        textAlignment: NSTextAlignment,
        textColor: UIColor,
        font: UIFont,
        backgroundColor: UIColor = .clear,
        clipsToBounds: Bool = true,
        cornerRadius: CGFloat = 0,
        isUserInteractionEnabled: Bool = false,
        numberOfLines: Int = 1,
        adjustsFontSizeToFitWidth: Bool = false,
        minimumScaleFactor: CGFloat = 0.8,
        lineBreakMode: NSLineBreakMode = .byTruncatingTail
    ) {
        super.init(frame: .zero)
        self.text = text
        self.textAlignment = textAlignment
        self.textColor = textColor
        self.font = font
        self.backgroundColor = backgroundColor
        self.clipsToBounds = clipsToBounds
        self.layer.cornerRadius = cornerRadius
        self.isUserInteractionEnabled = isUserInteractionEnabled
        self.numberOfLines = numberOfLines
        self.adjustsFontSizeToFitWidth = adjustsFontSizeToFitWidth
        self.minimumScaleFactor = minimumScaleFactor
        self.lineBreakMode = lineBreakMode
    }

}

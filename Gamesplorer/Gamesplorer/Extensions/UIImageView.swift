//
//  UIImageView.swift
//  Gamesplorer
//
//  Created by Mert Ozseven on 26.05.2024.
//

import UIKit
import Kingfisher

extension UIImageView {
    func loadImage(from urlString: String?, placeholder: UIImage? = UIImage(named: "placeholder")) {
        guard let urlString = urlString, let url = URL(string: urlString) else { return }
        
        let downsampling = DownsamplingImageProcessor(size: self.bounds.size)
        let processor = downsampling
        
        self.kf.indicatorType = .activity
        self.kf.setImage(
            with: url,
            placeholder: placeholder,
            options: [
                .processor(processor),
                .scaleFactor(UIScreen.main.scale),
                .transition(.fade(1)),
                .cacheOriginalImage
            ]
        )
    }
}

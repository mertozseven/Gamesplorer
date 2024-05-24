//
//  UIImage.swift
//  Gamesplorer
//
//  Created by Mert Ozseven on 18.05.2024.
//

import UIKit

extension UIImage {
    
    // MARK: - Image Resizing Method
    func resized(to targetSize: CGSize) -> UIImage? {
        let renderer = UIGraphicsImageRenderer(size: targetSize)
        let newImage = renderer.image { (context) in
            self.draw(in: CGRect(origin: .zero, size: targetSize))
        }
        
        return newImage
    }
    
}

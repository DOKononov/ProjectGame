//
//  UIImage+loadImage.swift
//  ProjectGame
//
//  Created by Dmitry Kononov on 7.02.22.
//

import Foundation
import UIKit

extension UIImageView {
    
    func loadImage(from string:String) {
        guard let url = URL(string: string) else { return }
//        DispatchQueue.main.async { [weak self] in
            if let data = try? Data(contentsOf: url) {
                if let image = UIImage(data: data) {
                    DispatchQueue.main.async {
                        self.image = image
                    }
                }
            }
//        }
    }
}

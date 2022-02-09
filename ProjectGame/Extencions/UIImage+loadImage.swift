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
        let queue = DispatchQueue(label: "DownloadImageQueue", qos: .userInitiated)
        
        guard let url = URL(string: string) else { return }
        queue.async { [weak self] in
            if let data = try? Data(contentsOf: url) {
                if let image = UIImage(data: data) {
                    DispatchQueue.main.async {
                        self?.image = image
                    }
                }
            }
        }
    }
}

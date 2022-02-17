//
//  UIActivityIndicatorView+IncreaceSize.swift
//  ProjectGame
//
//  Created by Dmitry Kononov on 17.02.22.
//

import Foundation
import UIKit

extension UIActivityIndicatorView {
    func scaleIndicator(factor: CGFloat) {
        transform = CGAffineTransform(scaleX: factor, y: factor)
    }
}

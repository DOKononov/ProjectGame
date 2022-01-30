//
//  UIViewController+getVC.swift
//  ProjectGame
//
//  Created by Dmitry Kononov on 30.01.22.
//

import Foundation
import UIKit


extension UIViewController {
    static func getVC(from storyboard: UIStoryboard) -> UIViewController {
        return storyboard.instantiateViewController(withIdentifier: "\(Self.self)") as! Self
    }
}

//
//  LoginVC+CustomElements.swift
//  ProjectGame
//
//  Created by Dmitry Kononov on 9.02.22.
//

import Foundation
import UIKit

extension LoginVC {
    
    func setupCustom(button: UIButton) {
        button.layer.cornerRadius = button.frame.height / 2
        button.layer.borderColor = .customBordercolor
        button.layer.borderWidth = 3
        button.clipsToBounds = true
    }
    
     func setupCustom(textField: UITextField, placeholderText: String) {
        let customPlaceholder = NSAttributedString(string: placeholderText,
                                                  attributes:
                                                    [NSAttributedString.Key.foregroundColor:
                                                        UIColor(red: 145 / 255,
                                                                        green: 117 / 255,
                                                                        blue: 101 / 255,
                                                                        alpha: 1)])
        textField.attributedPlaceholder = customPlaceholder
        textField.textColor = .white
        textField.font = UIFont(name: "BelweBT-Bold", size: 17)
        textField.layer.cornerRadius = textField.frame.size.height / 2
        textField.layer.borderColor = .customBordercolor
        textField.layer.borderWidth = 3
        textField.clipsToBounds = true
    }
    
    
    
}

//
//  LoginVC.swift
//  ProjectGame
//
//  Created by Dmitry Kononov on 29.01.22.
//

import UIKit

class LoginVC: UIViewController {
    
    var placeholderText = "Enter nickname"
    @IBOutlet weak var nicknameTF: UITextField!
    @IBOutlet weak var startButton: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupTF()
        setUpButton()
     
    }


    @IBAction func startDidPressed(_ sender: UIButton) {
       let nextVC =  GameVC.getVC(from: .main)
        navigationController?.pushViewController(nextVC, animated: true)
        
//        nextVC.modalPresentationStyle = .fullScreen
//        present(nextVC, animated: true, completion: nil)
        
    }
    
    

    private func setupTF() {
        
        let customPlaceholder = NSAttributedString(string: placeholderText,
                                                  attributes:
                                                    [NSAttributedString.Key.foregroundColor:
                                                        UIColor(red: 145 / 255,
                                                                        green: 117 / 255,
                                                                        blue: 101 / 255,
                                                                        alpha: 1)])
        nicknameTF.attributedPlaceholder = customPlaceholder
        nicknameTF.textColor = .white
        
        nicknameTF.layer.cornerRadius = nicknameTF.frame.size.height / 2
        nicknameTF.layer.borderColor = CGColor(red: 244 / 255,
                                               green: 239 / 255,
                                               blue: 167 / 255,
                                               alpha: 1)
        nicknameTF.layer.borderWidth = 3
        nicknameTF.clipsToBounds = true
    }
    
    private func setUpButton() {
        startButton.layer.cornerRadius = startButton.frame.height / 2
        nicknameTF.layer.borderColor = CGColor(red: 244 / 255,
                                               green: 239 / 255,
                                               blue: 167 / 255,
                                               alpha: 1)
        nicknameTF.layer.borderWidth = 3
        startButton.clipsToBounds = true
        
        
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        view.endEditing(true)
    }
    
    
}

//
//  LoginVC.swift
//  ProjectGame
//
//  Created by Dmitry Kononov on 29.01.22.
//

import UIKit

final class LoginVC: UIViewController {
    
    @IBOutlet weak var clearButton: UIButton!
    @IBOutlet private weak var nicknameTF: UITextField!
    @IBOutlet private weak var startButton: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupCustom(button: startButton)
        setupCustom(button: clearButton)
        setupCustom(textField: nicknameTF, placeholderText: "Enter nickname")
        loadPlayerName()
        nicknameTF.becomeFirstResponder()
        
    }
    
    @IBAction private func startDidPressed(_ sender: UIButton) {
        guard nicknameTF.hasText else {return}
        guard let nextVC =  GameVC.getVC(from: .main) else {return}
        guard let name = nicknameTF.text else {return}
        nextVC.playerName = name
        savePlayerName()
        
        navigationController?.pushViewController(nextVC, animated: true)
    }
    @IBAction private func clearButtonDidTapped(_ sender: UIButton) {
        nicknameTF.text = ""
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        view.endEditing(true)
    }
    
    private func savePlayerName() {
        UserDefaults.standard.set(nicknameTF.text, forKey: "playerName")
    }
    
    private func loadPlayerName() {
        guard let playerName = UserDefaults.standard.string(forKey: "playerName") else {return}
        nicknameTF.text = playerName
    }
    
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

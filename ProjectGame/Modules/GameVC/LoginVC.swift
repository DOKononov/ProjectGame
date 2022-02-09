//
//  LoginVC.swift
//  ProjectGame
//
//  Created by Dmitry Kononov on 29.01.22.
//

import UIKit

class LoginVC: UIViewController {
    
    @IBOutlet weak var nicknameTF: UITextField!
    @IBOutlet weak var startButton: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        LoginVC.setupCustom(button: startButton)
        LoginVC.setupCustom(textField: nicknameTF, placeholderText: "Enter nickname")
    }
    
    @IBAction func startDidPressed(_ sender: UIButton) {
        guard nicknameTF.hasText else {return}
        guard let nextVC =  GameVC.getVC(from: .main) as? GameVC else {return}
        guard let name = nicknameTF.text else {return}
        nextVC.playerName = name
        
        navigationController?.pushViewController(nextVC, animated: true)
    }
    
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        view.endEditing(true)
    }
    
}

//
//  MainNC.swift
//  ProjectGame
//
//  Created by Dmitry Kononov on 21.02.22.
//

import UIKit

class MainNC: UINavigationController {

    override func viewDidLoad() {
        super.viewDidLoad()

        guard let loginVC = LoginVC.getVC(from: .main) else {return}
        navigationController?.pushViewController(loginVC, animated: true)
    }

}

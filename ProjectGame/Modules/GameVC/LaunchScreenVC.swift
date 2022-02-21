//
//  LaunchScreenVC.swift
//  ProjectGame
//
//  Created by Dmitry Kononov on 21.02.22.
//

import UIKit

final class LaunchScreenVC: UIViewController {
    
    
    @IBOutlet weak var imageView: UIImageView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        launch()
    }
    
    
    private func launch() {
        
        
        UIView.animate(withDuration: 0.5, delay: 2) {
            self.imageView.transform = CGAffineTransform(rotationAngle: .pi)
            self.imageView.transform = CGAffineTransform(scaleX: 3, y: 3)
            self.imageView.alpha = 0
        } completion: { _ in
            guard let mainNC = MainNC.getVC(from: .main) else {return}
            mainNC.modalPresentationStyle = .fullScreen
            self.present(mainNC, animated: true, completion: nil)
        }
    }
    

    
}

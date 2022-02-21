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
            let endPosition: CGFloat = self.view.frame.origin.y - self.view.frame.height
            self.imageView.transform = CGAffineTransform(rotationAngle: .pi)
            self.imageView.transform = CGAffineTransform(scaleX: 1.5, y: 1.5)
            self.imageView.frame.origin.y = endPosition
        } completion: { _ in
            guard let mainNC = MainNC.getVC(from: .main) else {return}
            mainNC.modalPresentationStyle = .fullScreen
            self.present(mainNC, animated: true, completion: nil)
        }
    }
    

    
}

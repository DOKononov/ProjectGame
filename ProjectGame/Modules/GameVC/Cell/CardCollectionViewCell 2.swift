//
//  CardCollectionViewCell.swift
//  ProjectGame
//
//  Created by Dmitry Kononov on 12.01.22.
//

import UIKit


class CardCollectionViewCell: UICollectionViewCell {
    
    @IBOutlet weak var imageView: UIImageView!
    
    var card = Card()
    
    func setupCell() {
        
        if card.isFaceUp {
            UIView.transition(with: imageView,
                              duration: 1,
                              options: [ .transitionFlipFromLeft],
                              animations: {
                self.imageView.image = UIImage(named: self.card.name ?? "errorImage")
            },
                              completion: nil)
            
        } else {
            imageView.image = UIImage(named: "cardBack")
        }
    }
    
    
}


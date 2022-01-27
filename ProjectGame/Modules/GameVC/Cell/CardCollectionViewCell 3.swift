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
            flipWithAnimation(cardName: card.name ?? "errorImage")
        } else {
            flipWithAnimation(cardName: "cardBack")
            
        }
    }
    
    
    
    
    func flipWithAnimation(cardName: String) {
        UIView.transition(with: imageView,
                          duration: 0.5,
                          options: [.transitionFlipFromLeft]) {
            self.imageView.image = UIImage(named: cardName)
        }
    }
}


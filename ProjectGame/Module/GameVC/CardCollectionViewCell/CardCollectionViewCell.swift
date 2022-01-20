//
//  CardCollectionViewCell.swift
//  ProjectGame
//
//  Created by Dmitry Kononov on 12.01.22.
//

import UIKit


class CardCollectionViewCell: UICollectionViewCell {
    
    @IBOutlet weak var imageView: UIImageView!
    var card = Card(name: "errorImage")
    
    func setupCell() {
        if card.isFaceUp {
            imageView.image = UIImage(named:  card.name)
        } else {
            imageView.image = UIImage(named:  "cardBack")
        }
    }
    
    func flipCard() {
        if card.isFaceUp {
            flipWithAnimation(cardName: card.name)
        } else {
            flipWithAnimation(cardName: "cardBack")
        }
    }
    
    
    private func flipWithAnimation(cardName: String) {
        UIView.transition(with: imageView,
                          duration: 0.5,
                          options: [.transitionFlipFromLeft]) {
            self.imageView.image = UIImage(named: cardName)
        }
    }
}


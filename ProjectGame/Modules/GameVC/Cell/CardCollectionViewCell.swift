//
//  CardCollectionViewCell.swift
//  ProjectGame
//
//  Created by Dmitry Kononov on 12.01.22.
//

import UIKit


final class CardCollectionViewCell: UICollectionViewCell {
    
    @IBOutlet private weak var imageView: UIImageView!
    var card = Card(name: "cardBack")
    
    override var isSelected: Bool {
        didSet {
//            print(self.isSelected)
        }
    }
    
    func setupCell() {
        
        if card.isMatched {
            imageView.alpha = 0.5
        } else {
            imageView.alpha = 1
        }
        
        if card.isFacedUp {
            imageView.image = card.image
        } else {
            imageView.image = UIImage(named: "cardBack")
        }        
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()

        imageView.image = nil
        imageView.alpha = 1.0
    }
    
    
    func flipCard() {
        if card.isMatched {
            UIView.transition(with: imageView,
                              duration: 0.5,
                              options: [.transitionFlipFromLeft]) {
                self.imageView.alpha = 0.5
            }
        }
        
        if card.isFacedUp {
            UIView.transition(with: imageView,
                              duration: 0.5,
                              options: [.transitionFlipFromLeft]) {
                self.imageView.image = self.card.image
            }
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


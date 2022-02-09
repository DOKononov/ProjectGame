//
//  CardCollectionViewCell.swift
//  ProjectGame
//
//  Created by Dmitry Kononov on 12.01.22.
//

import UIKit


class CardCollectionViewCell: UICollectionViewCell {
    
    @IBOutlet weak var imageView: UIImageView!
    var card = Card(name: "cardBack")
    
    override var isSelected: Bool {
        didSet {
//            print(isSelected)
        }
    }
    
    func setupCell() {
        if card.isMatched {
            imageView.alpha = 0.5
        } else {
            imageView.alpha = 1
        }
        
        if card.isFacedUp {
            guard let imageURL = card.image else {return}
            imageView.loadImage(from: imageURL)
        } else {
            imageView.image = UIImage(named: "cardBack")
        }        
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()

//        imageView.image = nil
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
                guard let imageURL = self.card.image else {return}
                self.imageView.loadImage(from: imageURL)
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


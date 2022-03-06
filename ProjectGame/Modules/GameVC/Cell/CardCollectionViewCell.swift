//
//  CardCollectionViewCell.swift
//  ProjectGame
//
//  Created by Dmitry Kononov on 12.01.22.
//

import UIKit


final class CardCollectionViewCell: UICollectionViewCell {
    
    @IBOutlet private weak var imageView: UIImageView!
    
    func setupCell(card: Card) {
        card.isMatched ? (imageView.alpha = 0.5) : (imageView.alpha = 1)
        
        card.isFacedUp ?
        (imageView.image = card.image) :
        (imageView.image = UIImage(named: "cardBack"))
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        
        imageView.image = nil
        imageView.alpha = 1.0
    }
    
    
    func flipCard(card: Card) {
        if card.isFacedUp {
            guard let image = card.image else {return}
            flipWithAnimation(image: image)
        } else {
            card.isMatched ? (imageView.alpha = 0.5) : (imageView.alpha = 1)
            guard let image = UIImage(named: "cardBack") else {return}
            flipWithAnimation(image: image)
        }
    }
    
    
    private func flipWithAnimation(image: UIImage) {
        UIView.transition(with: imageView,
                          duration: 0.5,
                          options: [.transitionFlipFromLeft]) {
            self.imageView.image = image
        }
    }
}


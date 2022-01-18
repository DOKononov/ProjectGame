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
            imageView.image = UIImage(named: card.name ?? "errorImage")
        } else {
            imageView.image = UIImage(named: "cardBack")
        }
    }
    
    func setFaceUp(indexpath: IndexPath) {

        if card.isFaceUp == false {
            imageView.image = UIImage(named: card.name ?? "errorImage")
           card.isFaceUp = true
        }
    }
    
    
    func setFaceDown(indexpath: IndexPath) {
        imageView.image = UIImage(named: "cardBack")
        card.isFaceUp = false
    }
    
    
}


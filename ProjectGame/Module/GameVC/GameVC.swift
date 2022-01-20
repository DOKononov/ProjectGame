//
//  GameVC.swift
//  ProjectGame
//
//  Created by Dmitry Kononov on 12.01.22.
//

import UIKit

class GameVC: UIViewController {
    

    
    @IBOutlet weak var collectionView: UICollectionView!
    
    let padding: CGFloat = 10
    let cardsInRow: CGFloat = 4
    let heightAspectRatio: CGFloat = 1.3813
    var cardsArray = [Card]()
    var game = Game()
    
    var firstIndex: IndexPath?
    var secondIndex: IndexPath?
    var firsrCard: Card?
    var secondCard: Card?

    override func viewDidLoad() {
        super.viewDidLoad()
        collectionView.dataSource = self
        collectionView.delegate = self
        cardsArray = game.generateDeck()
        
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let cell = collectionView.cellForItem(at: indexPath) as? CardCollectionViewCell
        let card = cardsArray[indexPath.row]
        cell?.card = card
        

        
//        if firstIndex == nil {
//            firstIndex = indexPath
//            card.isFaceUp = !card.isFaceUp
//            firsrCard = card
//            cell?.flipCard()
//            print("1")
//        } else if secondIndex == nil {
//            secondIndex = indexPath
//            card.isFaceUp = !card.isFaceUp
//            secondCard = card
//            cell?.flipCard()
//            print("2")
//
//        }
//
        
        card.isFaceUp = !card.isFaceUp
        cell?.flipCard()
        
        
//        cardsArray[indexPath.row].isFaceUp = !cardsArray[indexPath.row].isFaceUp
//        collectionView.reloadItems(at: [indexPath])

    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "CardCollectionViewCell", for: indexPath) as? CardCollectionViewCell else {return UICollectionViewCell()}
        
        let card = cardsArray[indexPath.row]
        cell.card = card
        cell.setupCell()
        return cell
    }
    
}






//MARK: -extension GameVC
extension GameVC: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return cardsArray.count
    }

    //aspectRatio 1 : 1.3813
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        
        let fullFrameWidth = view.frame.width
        let paddingSpace = (cardsInRow + 1) * padding
        let cardWidth = (fullFrameWidth - paddingSpace) / cardsInRow
        return CGSize(width: cardWidth, height: cardWidth * heightAspectRatio)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return padding
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return padding
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        return UIEdgeInsets(top: padding, left: padding, bottom: padding, right: padding)
    }
    
}

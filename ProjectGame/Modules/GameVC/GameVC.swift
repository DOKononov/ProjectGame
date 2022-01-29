//
//  GameVC.swift
//  ProjectGame
//
//  Created by Dmitry Kononov on 12.01.22.
//

import UIKit

class GameVC: UIViewController {
    
    @IBOutlet weak var collectionView: UICollectionView!
    
    let padding: CGFloat = 20
    let cardsInRow: CGFloat = 3
    let heightAspectRatio: CGFloat = 1.3813
    
    var cardsArray = [Card]()
    var game = Game()
    
    var firstIndex: IndexPath?
    var secondIndex: IndexPath?
    
    var firstCard: Card?
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
        guard !card.isMatched else { return }
        
        cell?.card = card
                
        //OPEN FIRST CARD
        if firstIndex == nil {
            openFirstCard(indexpath: indexPath, card: card, cell: cell)
            
            //OPEN SECOND CARD
        } else if secondIndex == nil, firstIndex != indexPath  {
                    
            secondCard = card
            secondIndex = indexPath
            card.isFaceUp = true
            cell?.flipCard()
            
            //CHECK FOR MATCH
            if firstCard?.name == secondCard?.name {
                firstCard?.isMatched = true
                secondCard?.isMatched = true
            }
            
            //FLIP BOTH CARDS BACK
        } else {
            guard let firstIndex = firstIndex else { return }
            guard let secondIndex = secondIndex else { return }
            
            let cellOne = collectionView.cellForItem(at: firstIndex) as? CardCollectionViewCell
            let cellTwo = collectionView.cellForItem(at: secondIndex) as? CardCollectionViewCell
            
            self.firstIndex = nil
            self.secondIndex = nil
            
            cardsArray[firstIndex.row].isFaceUp = false
            cardsArray[secondIndex.row].isFaceUp = false
            
            cellOne?.flipCard()
            cellTwo?.flipCard()
            
            //OPEN NEW FIRST CARD
            openFirstCard(indexpath: indexPath, card: card, cell: cell)
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "CardCollectionViewCell", for: indexPath) as? CardCollectionViewCell else {return UICollectionViewCell()}

        let card = cardsArray[indexPath.row]
        cell.card = card
        cell.setupCell()
        return cell
    }
    
    
    func openFirstCard(indexpath: IndexPath, card: Card, cell: CardCollectionViewCell?) {
        firstCard = card
        firstIndex = indexpath
        card.isFaceUp = true
        cell?.flipCard()
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

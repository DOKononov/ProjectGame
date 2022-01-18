//
//  Game.swift
//  ProjectGame
//
//  Created by Dmitry Kononov on 16.01.22.
//

import Foundation

struct Game {
  
    var deckSize = 22
    
    let cardsNames = ["card1",
                      "card2",
                      "card3",
                      "card4",
                      "card5",
                      "card6",
                      "card7",
                      "card8",
                      "card9",
                      "card10",
                      "card11",
                      "card12",
                      "card13",
    ]
    

    func generateDeck() -> [Card]{
        
        var tempDeck = [Card]()
        var uniqueName = [String]()
        while tempDeck.count < deckSize {
            if let newCardName = cardsNames.randomElement() {
                if !uniqueName.contains(newCardName) {
                    uniqueName.append(newCardName)
                    tempDeck.append(Card(isFaceUp: false, name: newCardName))
                    tempDeck.append(Card(isFaceUp: false, name: newCardName))
                }
            }
        }
        return tempDeck.shuffled()
    }
    
}

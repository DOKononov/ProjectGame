//
//  Game.swift
//  ProjectGame
//
//  Created by Dmitry Kononov on 16.01.22.
//

import Foundation

struct Game {
    
    var deckSize = 0
    
    var cardsNames = ["card1",
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
    
    init (deckSize: Int = 12, deck: [Card] = []) {
        self.deckSize = deckSize
    }
    
    
    func generateDeckOffline() -> [Card]{
        
        var tempDeck = [Card]()
        var uniqueName = [String]()
        while tempDeck.count < deckSize {
            if let newCardName = cardsNames.randomElement() {
                if !uniqueName.contains(newCardName) {
                    uniqueName.append(newCardName)
                    tempDeck.append(Card.init(name: newCardName))
                    tempDeck.append(Card.init(name: newCardName))
                }
            }
        }
        return tempDeck.shuffled()
    }
    
    func generateDeckOnline(deckFromAPI:[Card], complition: (([Card]) -> Void)) {
        var tempDeck = [Card]()
        var uniqueName = [String]()
        while tempDeck.count < deckSize {
            if let newCard = deckFromAPI.randomElement() {
                if !uniqueName.contains(newCard.name) {
                    uniqueName.append(newCard.name)
                    tempDeck.append(newCard)
                    tempDeck.append(Card(newCard))
                }
            }
        }
        complition(tempDeck.shuffled())
    }
    
    
    
}



//
//  Game.swift
//  ProjectGame
//
//  Created by Dmitry Kononov on 16.01.22.
//

import Foundation

struct Game {
    
    var deckSize = 0
    
    init (deckSize: Int = 12) {
        self.deckSize = deckSize
    }
    
    func generateDeck(deckFromAPI:[Card], complition: @escaping ([Card]) -> Void) {
        let myQueue = DispatchQueue(label: "myQueue", qos: .default)
        var tempDeck = [Card]()
        var uniqueName = [String]()
        myQueue.async {
            while tempDeck.count < deckSize {
                if let newCard = deckFromAPI.randomElement() {
                    if !uniqueName.contains(newCard.name) {
                        uniqueName.append(newCard.name)
                        tempDeck.append(newCard)
                        tempDeck.append(Card(newCard))
                    }
                }
            }
        }
        DispatchQueue.main.async {
            complition(tempDeck.shuffled())
        }
    }
}



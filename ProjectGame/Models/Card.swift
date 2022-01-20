//
//  Card.swift
//  ProjectGame
//
//  Created by Dmitry Kononov on 16.01.22.
//

import Foundation
 
class Card {
    
    var name: String
    var isFaceUp: Bool
    var isMatched: Bool
    
    init(name: String, isFaceUp: Bool = false, isMatched: Bool = false) {
        self.name = name
        self.isFaceUp = isFaceUp
        self.isMatched = isMatched
        
    }
}

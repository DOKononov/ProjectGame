//
//  Deck.swift
//  ProjectGame
//
//  Created by Dmitry Kononov on 6.02.22.
//

import Foundation

class Deck: Decodable {
    
    var deck: [Card] = []

    enum CodingKeys: String, CodingKey {
        case deck = "cards"
    }
    
    init (deck: [Card]?) {
        self.deck = deck ?? []
    }
    
    required init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        self.deck = try container.decode([Card].self, forKey: .deck)
    }
}

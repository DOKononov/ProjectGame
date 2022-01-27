//
//  Card.swift
//  ProjectGame
//
//  Created by Dmitry Kononov on 16.01.22.
//

import Foundation
 
final class Card: Codable {
    
    var name: String
    var isFaceUp: Bool
    var isMatched: Bool
    
    init(name: String, isFaceUp: Bool = false, isMatched: Bool = false) {
        self.name = name
        self.isFaceUp = isFaceUp
        self.isMatched = isMatched
        
    }

    
//    enum CodingKeys: CodingKey {
//        case name
//        case isFaceUp
//        case isMatched
//    }
//
//    init(from decoder: Decoder) throws {
//        let container = try decoder.container(keyedBy: CodingKeys.self)
//        self.name = try container.decode(String.self, forKey: .name)
//        self.isMatched = try container.decode(Bool.self, forKey: .isMatched)
//        self.isFaceUp = try container.decode(Bool.self, forKey: .isFaceUp)
//    }
//
//    func encode(to encoder: Encoder) throws {
//        var container = encoder.container(keyedBy: CodingKeys.self)
//        try container.encode(name, forKey: .name)
//        try container.encode(isFaceUp, forKey: .isFaceUp)
//        try container.encode(isMatched, forKey: .isMatched)
//    }
    
}



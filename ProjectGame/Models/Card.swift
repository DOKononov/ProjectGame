//
//  Card.swift
//  ProjectGame
//
//  Created by Dmitry Kononov on 16.01.22.
//

import Foundation
 
final class Card: Decodable {

    let id: Int?
    let name: String
    let image: String?
    var isFacedUp: Bool
    var isMatched: Bool
    
    enum CodingKeys: CodingKey {
        case id
        case name
        case image
        case isFaceUp
        case isMatched
    }

    init(id: Int? = nil, name: String, image: String? = nil, isFaceUp: Bool = false, isMatched: Bool = false) {
        self.id = id
        self.name = name
        self.image = image
        self.isFacedUp = isFaceUp
        self.isMatched = isMatched

    }
    
    
    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        self.id = try container.decode(Int.self, forKey: .id)
        self.name = try container.decode(String.self, forKey: .name)
        self.image = try container.decode(String.self, forKey: .image)
        self.isFacedUp = false
        self.isMatched = false
    }
    
}




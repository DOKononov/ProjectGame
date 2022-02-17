//
//  Card.swift
//  ProjectGame
//
//  Created by Dmitry Kononov on 16.01.22.
//

import Foundation
import UIKit
 
final class Card: Decodable {

    let id: Int?
    let name: String
    let imageUrl: String?
    var isFacedUp: Bool
    var isMatched: Bool
    var image: UIImage?

    
    enum CodingKeys: String, CodingKey {
        case id
        case name
        case imageUrl = "image"
        case isFaceUp
        case isMatched
    }

    init(id: Int? = nil, name: String, imageUrl: String? = nil, isFaceUp: Bool = false, isMatched: Bool = false) {
        self.id = id
        self.name = name
        self.imageUrl = imageUrl
        self.isFacedUp = isFaceUp
        self.isMatched = isMatched

    }
    
    init(_ card: Card) {
        self.id = card.id
        self.name = card.name
        self.imageUrl = card.imageUrl
        self.isFacedUp = card.isFacedUp
        self.isMatched = card.isMatched
    }
    
    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        self.id = try container.decode(Int.self, forKey: .id)
        self.name = try container.decode(String.self, forKey: .name)
        self.imageUrl = try container.decode(String.self, forKey: .imageUrl)
        self.isFacedUp = false
        self.isMatched = false
    }
    
}




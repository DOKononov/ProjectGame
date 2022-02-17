//
//  CardsDataDownloader.swift
//  ProjectGame
//
//  Created by Dmitry Kononov on 16.02.22.
//

import Foundation
import UIKit

typealias CardsDataDownloaderHandler = ([Card]) -> Void

final class CardsDataDownloader {
    
    private let downloadCardsDataQueue = DispatchQueue(label: "downloadCardsDataQueue", qos: .userInitiated, attributes: .concurrent)
    private let safeWriteDataQueue = DispatchQueue(label: "safeWriteDataQueue")
    
    func download(_ cards: [Card], completion: @escaping CardsDataDownloaderHandler) {
        let dispatchGroup = DispatchGroup()
        
        dispatchGroup.notify(queue: .main) {
            completion(cards)
        }
        
        cards.forEach { card in
            dispatchGroup.enter()
            downloadCardsDataQueue.async { [weak self] in
                guard let imageUrlStr = card.imageUrl,
                      let imageUrl = URL(string: imageUrlStr),
                      let data = try? Data(contentsOf: imageUrl),
                      let image = UIImage(data: data) else {
//                          print("\(Self.self): image NOT LOADED with url \(card.imageUrl)")
                          dispatchGroup.leave()
                          return
                      }
                self?.safeWriteDataQueue.async {
                    card.image = image
//                    print("\(Self.self): image loaded with url \(card.imageUrl)")
                    dispatchGroup.leave()
                }
            }
        }
    }
}

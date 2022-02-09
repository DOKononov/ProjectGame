//
//  NetworkService.swift
//  ProjectGame
//
//  Created by Dmitry Kononov on 6.02.22.
//

import Foundation
import UIKit


struct NetworkService {
    private let host = "https://us.api.blizzard.com/hearthstone"
    private let token = "_token=USnh4Fe8qLg0eS8GvjzOV23qbU5EDhBOFC"
    
    func getCards(complition: @escaping ([Card]) -> Void) {
        
        guard let urlString = URL(string: host + "/cards?locale=en_US&type=minion&pageSize=0&access" + token) else { return }
        var request = URLRequest(url: urlString)
        request.httpMethod = "GET"

        URLSession.shared.dataTask(with: request) { responceData, responce, error in
            if let error = error {
                print(error.localizedDescription)
            } else if let data = responceData, let responce = responce as? HTTPURLResponse {
                print("responce.statusCode: \(responce.statusCode)")
                if let deck = try? JSONDecoder().decode(Deck.self, from: data) {
                    DispatchQueue.main.async {
                        complition(deck.deck)
                    }
                }
                
            }
        }.resume()
    }
    
    
    
}


//NetworkService().getCards { deck in
//    deck.deck.forEach { print($0.name)}
//}

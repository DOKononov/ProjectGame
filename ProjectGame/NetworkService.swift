//
//  NetworkService.swift
//  ProjectGame
//
//  Created by Dmitry Kononov on 6.02.22.
//

import Foundation
import UIKit


//https://us.api.blizzard.com/hearthstone/cards?locale=en_US&type=minion&pageSize=0&access_token=USpvxt4O1BaJe5ip77pqdCcy4WDX1IdPdh

struct NetworkService {
    private let host = "https://us.api.blizzard.com/hearthstone"
    private let token = "_token=USpvxt4O1BaJe5ip77pqdCcy4WDX1IdPdh"
    
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


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
    private let path = "/cards?locale=en_US&type=minion&pageSize=0&access"
    private let token = "_token=USyzz43ZGlq09HZf6m8gLO6ZJ6zr4S034O"

    func getCards(complition: @escaping ([Card]) -> Void) {
        
        guard let urlString = URL(string: host + path + token) else { return }
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


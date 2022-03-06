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
    private let token = "_token=USTtBGxpP1L9rbc80B5czI9mWVnrehK2R8"
    private let successResponce = 200...299

    func getCards(complition: @escaping ([Card]?, String?) -> Void) {
        
        guard let urlString = URL(string: host + path + token) else { return }
        var request = URLRequest(url: urlString)
        request.httpMethod = "GET"

        URLSession.shared.dataTask(with: request) { responceData, responce, error in
            if let error = error {
                complition(nil, error.localizedDescription)
                
            } else if let data = responceData, let responce = responce as? HTTPURLResponse {
                
                if  successResponce.contains(responce.statusCode) {
                    if let deck = try? JSONDecoder().decode(Deck.self, from: data) {
                        DispatchQueue.main.async {
                            complition(deck.deck, nil)
                        }
                    }
                } else {
                    complition(nil, "Error: responce.statusCode: \(responce.statusCode)")
                }
            }
        }.resume()
    }
}


//
//  ApiManager.swift
//  ConvertCurrency
//
//  Created by Roberth Henrique Siqueira on 30/08/19.
//  Copyright © 2019 Roberth Siqueira. All rights reserved.
//

import Foundation

class APIManager {
  static let baseURL = URL(string: "https://api.exchangeratesapi.io")
  typealias parameters = [String: Any]
  
  static func requestData<T: Codable>(completion: @escaping (Result<T, Error>) -> ()) {
    let resource = "latest"
    
    guard let url = baseURL?.appendingPathComponent(resource) else { return }
    
    var urlComponents = URLComponents(url: url, resolvingAgainstBaseURL: false)
    urlComponents?.queryItems = [
      URLQueryItem(name: "base", value: "USD"),
      URLQueryItem(name: "symbols", value: "BRL")
    ]
    
    guard let urlToRequest = urlComponents?.url else { return }
    
    URLSession.shared.dataTask(with: urlToRequest) { (data, response, error) in
      if let error = error {
        completion(.failure(error))
      }
      do {
        let response = try JSONDecoder().decode(T.self, from: data!)
        completion(.success(response))
      } catch let err {
        completion(.failure(err))
      }
    }.resume()
  }
}

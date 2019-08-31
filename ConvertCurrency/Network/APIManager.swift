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
  
  static func requestData<T: Codable>(with url: String,
                                      parameters: parameters?,
                                      completion: @escaping (Result<T, Error>) -> ()) {
    guard let url = baseURL?.appendingPathComponent(url) else { return }
    
    var urlRequest = URLRequest(url: url, cachePolicy: .useProtocolCachePolicy, timeoutInterval: 10)
    
    if let parameters = parameters {
      let parameterData = parameters.reduce("") { (result, param) -> String in
        return result + "&\(param.key)=\(param.value as! String)"
        }.data(using: .utf8)
      urlRequest.httpBody = parameterData
    }
    
    URLSession.shared.dataTask(with: urlRequest) { (data, response, error) in
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

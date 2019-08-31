//
//  ConvertCurrencyViewModel.swift
//  ConvertCurrency
//
//  Created by Roberth Henrique Siqueira on 30/08/19.
//  Copyright © 2019 Roberth Siqueira. All rights reserved.
//

import Foundation

protocol ConvertCurrencyViewModelProtocol {
  func requestBaseCurrency()
}

class ConvertCurrencyViewModel: ConvertCurrencyViewModelProtocol {
  func requestBaseCurrency() {
    let url = "latest"
    
    APIManager.requestData(with: url, parameters: nil) { (response: Result<String, Error>) in
      switch response {
      case .success:
        print("Success")
      case .failure:
        print("Failure")
      }
    }
  }
}

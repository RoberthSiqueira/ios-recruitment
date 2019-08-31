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
    APIManager.requestData(completion: { (response: Result<Currency, Error>) in
      switch response {
      case .success(let rates):
        print("Success")
      case .failure:
        print("Failure")
      }
    })
  }
}

//
//  ConvertCurrencyViewModel.swift
//  ConvertCurrency
//
//  Created by Roberth Henrique Siqueira on 30/08/19.
//  Copyright © 2019 Roberth Siqueira. All rights reserved.
//

import Foundation
import RxSwift

protocol ConvertCurrencyViewModelProtocol {
  func requestBaseCurrency()
}

class ConvertCurrencyViewModel: ConvertCurrencyViewModelProtocol {
  public let loading: PublishSubject<Bool> = PublishSubject()
  public let realString: PublishSubject<String> = PublishSubject()
  public let dateString: PublishSubject<String> = PublishSubject()
  
  func requestBaseCurrency() {
    loading.onNext(true)
    APIManager.requestData(completion: { [unowned self] (response: Result<Rates, Error>) in
      self.loading.onNext(false)
      switch response {
      case .success(let rates):
        let currencies = rates.currencies
        self.dateString.onNext(rates.date.formatYYYYMMDDDateString())
        self.realString.onNext(String(format: "%.2f", currencies.BRL).replacingOccurrences(of: ".", with: ","))
      case .failure:
        print("Failure")
      }
    })
  }
}

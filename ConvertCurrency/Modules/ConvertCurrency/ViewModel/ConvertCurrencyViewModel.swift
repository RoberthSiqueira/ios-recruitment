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
  func dollarToReal(value: NSNumber) -> String
  func realToDollar(value: NSNumber) -> String
}

class ConvertCurrencyViewModel: ConvertCurrencyViewModelProtocol {
  public let loading: PublishSubject<Bool> = PublishSubject()
  public let realString: PublishSubject<String> = PublishSubject()
  public let dateString: PublishSubject<String> = PublishSubject()
  
  private var realValue: Double = 0.0
  
  func requestBaseCurrency() {
    loading.onNext(true)
    APIManager.requestData(completion: { [unowned self] (response: Result<Rates, Error>) in
      self.loading.onNext(false)
      switch response {
      case .success(let rates):
        self.realValue = rates.currencies.BRL
        self.dateString.onNext(rates.date.formatYYYYMMDDDateString())
        self.realString.onNext(String(format: "%.2f", self.realValue).replacingOccurrences(of: ".", with: ","))
      case .failure:
        print("Failure")
      }
    })
  }
  
  func dollarToReal(value: NSNumber) -> String {
    let result = Double(truncating: value) * realValue
    let resultStr = String(result.roundToDecimal(2)).currencyInputFormatting(localeIdentifier: "pt_BR")
    if let real = resultStr {
      return real
    } else {
      return ""
    }
  }
  
  func realToDollar(value: NSNumber) -> String {
    let result = Double(truncating: value) / realValue
    let resultStr = String(result.roundToDecimal(2)).currencyInputFormatting(localeIdentifier: "pt_BR")
    if let dollar = resultStr {
      return dollar
    } else {
      return ""
    }
  }
}

//
//  Double+Currency.swift
//  ConvertCurrency
//
//  Created by Roberth Henrique Siqueira on 31/08/19.
//  Copyright © 2019 Roberth Siqueira. All rights reserved.
//

import Foundation

extension Double {
  func currency(identifier: String = "pt_BR") -> String {
    let formatter = NumberFormatter()
    formatter.usesGroupingSeparator = true
    formatter.numberStyle = .currency
    formatter.locale = Locale(identifier: identifier)
    formatter.paddingPosition = .afterPrefix
    formatter.paddingCharacter = " "
    guard let currency = formatter.string(from: NSNumber(value: self)) else {
      return "-"
    }
    return currency
  }
}

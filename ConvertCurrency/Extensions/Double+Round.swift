//
//  Double+Currency.swift
//  ConvertCurrency
//
//  Created by Roberth Henrique Siqueira on 31/08/19.
//  Copyright © 2019 Roberth Siqueira. All rights reserved.
//

import Foundation

extension Double {
  func roundToDecimal(_ fractionDigits: Int) -> Double {
    let multiplier = pow(10, Double(fractionDigits))
    return Darwin.round(self * multiplier) / multiplier
  }
}

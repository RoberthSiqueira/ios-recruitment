//
//  String+Number.swift
//  ConvertCurrency
//
//  Created by Roberth Henrique Siqueira on 31/08/19.
//  Copyright © 2019 Roberth Siqueira. All rights reserved.
//

import Foundation

extension String {
  func currencyInputFormatting(localeIdentifier: String = "pt_BR") -> String? {
    let defaultValue = NSNumber(value: 0)
    let formatter = NumberFormatter()
    formatter.numberStyle = .decimal
    formatter.locale = Locale(identifier: localeIdentifier)
    formatter.maximumFractionDigits = 2
    formatter.minimumFractionDigits = 2
    formatter.paddingPosition = .afterPrefix
    formatter.paddingCharacter = " "
    if let number = self.toRawNumber(), let formattedNumber = formatter.string(from: number) {
      return formattedNumber
    } else {
      return formatter.string(from: defaultValue)
    }
  }
  
  func toRawNumber() -> NSNumber? {
    do {
      var amountWithPrefix = self
      let regex = try NSRegularExpression(pattern: "[^0-9]", options: .caseInsensitive)
      amountWithPrefix = regex.stringByReplacingMatches(in: amountWithPrefix,
                                                        options: NSRegularExpression.MatchingOptions(rawValue: 0),
                                                        range: NSRange(location: 0, length: count),
                                                        withTemplate: "")
      if let double = Double(amountWithPrefix) {
        let number = NSNumber(value: (double / 100))
        
        guard number != 0 as NSNumber else {
          return nil
        }
        return number
      }
      return nil
    } catch {
      return nil
    }
  }
}

//
//  RatesModel.swift
//  ConvertCurrency
//
//  Created by Roberth Henrique Siqueira on 31/08/19.
//  Copyright © 2019 Roberth Siqueira. All rights reserved.
//

import Foundation

struct Rates: Codable {
  let currencies: Currency
  let date: String
  
  enum CodingKeys: String, CodingKey {
    case currencies = "rates"
    case date
  }
}

//
//  String+Date.swift
//  ConvertCurrency
//
//  Created by Roberth Henrique Siqueira on 31/08/19.
//  Copyright © 2019 Roberth Siqueira. All rights reserved.
//

import Foundation

extension String {
  func formatYYYYMMDDDateString() -> String {
    
    let dateFormatterGet = DateFormatter()
    dateFormatterGet.dateFormat = "yyyy-MM-dd"
    
    let dateFormatterPrint = DateFormatter()
    dateFormatterPrint.dateFormat = "dd/MM/yyyy"
    
    if let date = dateFormatterGet.date(from: self) {
      return dateFormatterPrint.string(from: date)
    }
    
    return ""
  }
}

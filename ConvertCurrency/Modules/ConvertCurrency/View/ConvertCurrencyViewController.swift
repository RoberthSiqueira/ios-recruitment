//
//  ViewController.swift
//  ConvertCurrency
//
//  Created by Roberth Henrique Siqueira on 30/08/19.
//  Copyright © 2019 Roberth Siqueira. All rights reserved.
//

import UIKit
import RxSwift

class ConvertCurrencyViewController: UIViewController {
  
  var convertCurrencyVM = ConvertCurrencyViewModel()

  override func viewDidLoad() {
    super.viewDidLoad()
    convertCurrencyVM.requestBaseCurrency()
  }
}

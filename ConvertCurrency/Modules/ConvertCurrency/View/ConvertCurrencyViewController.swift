//
//  ViewController.swift
//  ConvertCurrency
//
//  Created by Roberth Henrique Siqueira on 30/08/19.
//  Copyright © 2019 Roberth Siqueira. All rights reserved.
//

import UIKit
import RxSwift
import RxCocoa

class ConvertCurrencyViewController: UIViewController {
  
  @IBOutlet weak var descLabel: UILabel!
  @IBOutlet weak var consultedLabel: UILabel!
  @IBOutlet weak var loadingIndicator: UIActivityIndicatorView!
  
  public var currency = PublishSubject<Currency>()
  private let disposeBag = DisposeBag()
  
  var convertCurrencyVM = ConvertCurrencyViewModel()
  
  private enum Strings {
    static let desc = "1 dólar Americano é igual a %@ real Brasileiro"
  }
  
  override func viewDidLoad() {
    super.viewDidLoad()
    setupBind()
    convertCurrencyVM.requestBaseCurrency()
  }
  
  private func setupBind() {
    convertCurrencyVM.loading
      .bind(to: loadingIndicator.rx.isAnimating)
      .disposed(by: disposeBag)
    
    convertCurrencyVM.realString
      .asObserver()
      .map({ realValue -> String in
        return String(format: Strings.desc, realValue)
      })
      .bind(to: descLabel.rx.text)
      .disposed(by: disposeBag)
    
    convertCurrencyVM.dateString
      .asObserver()
      .bind(to: consultedLabel.rx.text)
      .disposed(by: disposeBag)
  }
}

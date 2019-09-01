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
  
  // MARK: - Outlets
  @IBOutlet weak var descLabel: UILabel!
  @IBOutlet weak var consultedLabel: UILabel!
  @IBOutlet weak var loadingIndicator: UIActivityIndicatorView!
  @IBOutlet weak var dollarTextField: UITextField!
  @IBOutlet weak var realTextFIeld: UITextField!
  @IBOutlet weak var errorView: UIView!
  @IBOutlet weak var tryAgainButton: UIButton!
  
  // MARK: - Class properties
  private let disposeBag = DisposeBag()
  private enum Strings {
    static let desc = "1 dólar Americano é igual \na %@ real Brasileiro"
  }
  
  // MARK: - Public properties
  var convertCurrencyVM = ConvertCurrencyViewModel()
  
  // MARK: - Life cicle
  override func viewDidLoad() {
    super.viewDidLoad()
    configView()
    setupBind()
    fetchCurrency()
  }
  
  private func configView() {
    setupToHideKeyboardOnTapOnView()
    configTextFields()
    configButton()
  }
  
  private func configTextFields() {
    let textFields: [UITextField] = [dollarTextField, realTextFIeld]
    textFields.forEach({
      $0.layer.masksToBounds = false
      $0.layer.shadowRadius = 1.0
      $0.layer.shadowColor = UIColor.lightGray.cgColor
      $0.layer.shadowOffset = CGSize(width: 1.0, height: 1.0)
      $0.layer.shadowOpacity = 1.0
      $0.addTarget(self, action: #selector(textFieldDidChange(_:)), for: .editingChanged)
    })
  }
  
  private func configButton() {
    let blueColor = UIColor(red: 0.0, green: 122.0/255.0, blue: 1.0, alpha: 1.0)
    tryAgainButton.setTitleColor(blueColor, for: .normal)
    tryAgainButton.layer.masksToBounds = true
    tryAgainButton.layer.cornerRadius = 8.0
    tryAgainButton.layer.borderWidth = 1.0
    tryAgainButton.layer.borderColor = blueColor.cgColor
  }
  
  private func fetchCurrency() {
    convertCurrencyVM.requestBaseCurrency()
  }
  
  private func setupBind() {
    convertCurrencyVM.loading
      .bind(to: loadingIndicator.rx.isAnimating)
      .disposed(by: disposeBag)
    
    convertCurrencyVM.errorLoading
      .bind(to: errorView.rx.isHidden)
      .disposed(by: disposeBag)
    
    convertCurrencyVM.realString
      .map({ realValue -> String in
        return String(format: Strings.desc, realValue)
      })
      .bind(to: descLabel.rx.text)
      .disposed(by: disposeBag)
    
    convertCurrencyVM.dateString
      .bind(to: consultedLabel.rx.text)
      .disposed(by: disposeBag)
    
    convertCurrencyVM.realTF
      .asObserver()
      .bind(to: realTextFIeld.rx.text)
      .disposed(by: disposeBag)
    
    convertCurrencyVM.dollarTF
      .asObserver()
      .bind(to: dollarTextField.rx.text)
      .disposed(by: disposeBag)
  }
  
  @objc private func textFieldDidChange(_ textField: UITextField) {
    guard let text = textField.text, let number = text.toRawNumber() else {
      dollarTextField.text = ""
      realTextFIeld.text = ""
      return
    }
    switch textField {
    case dollarTextField:
      textField.text = text.currencyInputFormatting(localeIdentifier: Constants.Languages.enUS)
      convertCurrencyVM.dollarToReal(value: number)
    case realTextFIeld:
      textField.text = text.currencyInputFormatting(localeIdentifier: Constants.Languages.ptBR)
      convertCurrencyVM.realToDollar(value: number)
    default:
      break
    }
  }
  
  // MARK: - Actions
  @IBAction func tryAgainAction(_ sender: UIButton) {
    errorView.isHidden = true
    fetchCurrency()
  }
}

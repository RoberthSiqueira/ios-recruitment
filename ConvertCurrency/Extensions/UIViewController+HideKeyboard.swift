//
//  File.swift
//  ConvertCurrency
//
//  Created by Roberth Henrique Siqueira on 01/09/19.
//  Copyright © 2019 Roberth Siqueira. All rights reserved.
//

import UIKit

extension UIViewController {
  func setupToHideKeyboardOnTapOnView() {
    let tap: UITapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(UIViewController.dismissKeyboard))
    
    tap.cancelsTouchesInView = false
    view.addGestureRecognizer(tap)
  }
  
  @objc func dismissKeyboard() {
    view.endEditing(true)
  }
}

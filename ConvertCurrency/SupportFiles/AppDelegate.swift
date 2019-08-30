//
//  AppDelegate.swift
//  ConvertCurrency
//
//  Created by Roberth Henrique Siqueira on 30/08/19.
//  Copyright © 2019 Roberth Siqueira. All rights reserved.
//

import UIKit

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

  var window: UIWindow?

  func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
    window = UIWindow(frame: UIScreen.main.bounds)
    let homeStoryboard = UIStoryboard(name: "ConvertCurrency", bundle: nil)
    let homeVC = homeStoryboard.instantiateViewController(withIdentifier: "convertcurrency")
    window?.rootViewController = homeVC
    window?.makeKeyAndVisible()
    return true
  }
}


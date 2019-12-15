//
//  ModeViewController.swift
//  PasscodeLock
//
//  Created by Oleg Ryasnoy on 19.04.17.
//  Copyright © 2017 Oleg Ryasnoy. All rights reserved.
//

import UIKit

class ModeViewController: UIViewController {

  @IBAction func createMode(_ sender: UIButton) {
    pin(.create)
  }
  
  @IBAction func changeMode(_ sender: UIButton) {
    pin(.change)
  }
  
  @IBAction func deactiveMode(_ sender: UIButton) {
    pin(.deactive)
  }
  
  @IBAction func validateMode(_ sender: UIButton) {
    pin(.validate)
  }
  
  func pin(_ mode: ALMode) {
    
    var options = ALOptions()
    options.image = UIImage(named: "face")!
    options.title = "Devios Ryasnoy"
    options.isSensorsEnabled = true
    options.onSuccessfulDismiss = { (mode: ALMode?) in
        if let mode = mode {
            print("Password \(String(describing: mode))d successfully")
        } else {
            print("User Cancelled")
        }
    }
    options.onFailedAttempt = { (mode: ALMode?) in
        print("Failed to \(String(describing: mode))")
    }
    AppLocker.present(with: mode, and: options, over: self)
  }

}


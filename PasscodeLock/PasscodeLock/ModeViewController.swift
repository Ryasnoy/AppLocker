//
//  ModeViewController.swift
//  PasscodeLock
//
//  Created by Oleg Ryasnoy on 19.04.17.
//  Copyright © 2017 Oleg Ryasnoy. All rights reserved.
//

import UIKit

class ModeViewController: UIViewController {
  
  var mode: LockerMode!

  @IBAction func createMode(_ sender: UIButton) {
    pin(.create)
  }
  
  @IBAction func changeMode(_ sender: UIButton) {
    pin(.change)
  }
  
  @IBAction func desactiveMode(_ sender: UIButton) {
    pin(.desactive)
  }
  
  @IBAction func validateMode(_ sender: UIButton) {
    pin(.validate)
  }
  
  func pin(_ mode: LockerMode) {
    
    var config = LockerConfig()
    config.image = UIImage(named: "face")!
    config.title = "Devios Ryasnoy"
    
    AppLocker.present(with: mode, and: config)
  }

}


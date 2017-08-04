//
//  View.swift
//  PasscodeLock
//
//  Created by Oleg Ryasnoy on 18.04.17.
//  Copyright © 2017 Oleg Ryasnoy. All rights reserved.
//

import UIKit

extension UIView {
  func rounded() {
    layer.cornerRadius = frame.width/2
    layer.borderWidth = 1
    layer.borderColor = UIColor.white.cgColor
  }
}

class Indicator: UIView {
  
  var isMasked = false
  
  override func layoutSubviews() {
    super.layoutSubviews()
    rounded()
  }
}

class ImageView: UIImageView {
  override func layoutSubviews() {
    super.layoutSubviews()
    rounded()
  }
}

class Button: UIButton {
  override func layoutSubviews() {
    super.layoutSubviews()
    rounded()
  }
}

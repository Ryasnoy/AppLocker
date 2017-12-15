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
  // MARK: - Animation
  func shake(delegate: CAAnimationDelegate) {
    let animationKeyPath = "transform.translation.x"
    let shakeAnimation = "shake"
    let duration = 0.6
    let animation = CAKeyframeAnimation(keyPath: animationKeyPath)
    animation.timingFunction = CAMediaTimingFunction(name: kCAMediaTimingFunctionLinear)
    animation.duration = duration
    animation.values = [-20.0, 20.0, -20.0, 20.0, -10.0, 10.0, -5.0, 5.0, 0.0]
    animation.delegate = delegate
    layer.add(animation, forKey: shakeAnimation)
  }
}


class Indicator: UIView {
  
  var isNeedClear = false
  
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

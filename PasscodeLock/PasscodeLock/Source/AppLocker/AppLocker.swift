//
//  AppLocker.swift
//  AppLocker
//
//  Created by Oleg Ryasnoy on 07.07.17.
//  Copyright © 2017 Oleg Ryasnoy. All rights reserved.
//

import UIKit
import AudioToolbox
import LocalAuthentication

fileprivate enum LockerConstants {
  static let deleteTag = 1000 // Button tag
  static let cancelTag = 1001 // Button tag
  static let kPincode = "pincode" // Key for saving pincode to UserDefaults
  static let kLocalizedReason = "Unlock with sensor" // Your message when sensors must be shown
  static let appLockerNib = "AppLocker" // Nib name
  static let maxPinLength = 4 // max pincode lenght characters
  static let animationKeyPath = "transform.translation.x"
  static let shakeAnimation = "shake"
  static let shakeDuration = 0.6
  static let indicatorDuration = 0.3
}

struct LockerConfig { // The structure used to display the controller
  var title: String?
  var subtitle: String?
  var image: UIImage?
  var color: UIColor?
  var isSensorsEnabled: Bool?
}

enum LockerMode { // Modes for AppLocker
  case validate
  case change
  case desactive
  case create
}

class AppLocker: UIViewController {
  
  // Top view
  @IBOutlet weak var photoImageView: UIImageView!
  @IBOutlet weak var messageLabel: UILabel!
  @IBOutlet weak var submessageLabel: UILabel!
  
  @IBOutlet weak var cancelButton: Button!
  
  // Rounded pin indicators
  @IBOutlet var pinIndicators: [Indicator]!
  
  // Pincode
  fileprivate var context = LAContext()
  fileprivate var pin = "" // Entered pincode
  fileprivate var reservedPin = "" // Reserve pincode for confirm
  fileprivate var isNeedConfirm = true // Confirmation for create mode
  fileprivate var savedPin: String? {
    get { // Get saved pincode
      return UserDefaults.standard.string(forKey: LockerConstants.kPincode)
    }
    set { // Set pincode to UserDefaults
      UserDefaults.standard.set(newValue, forKey: LockerConstants.kPincode)
    }
  }
  
  fileprivate var mode: LockerMode! {
    didSet {
      switch mode! {
      case .create:
        submessageLabel.text = "Create your passcode" // Your submessage for create mode
      case .change:
        submessageLabel.text = "Enter your passcode" // Your submessage for change mode
      case .desactive:
        submessageLabel.text = "Enter your passcode" // Your submessage for desactive mode
      case .validate:
        submessageLabel.text = "Enter your passcode" // Your submessage for validate mode
        cancelButton.isHidden = true
        isNeedConfirm = false
      }
    }
  }
  
  fileprivate func precreateSettings () { // Precreate settings for change mode
    mode = .create
    clearView()
    submessageLabel.text = "Create your passcode"
  }
  
  fileprivate func indicatorChangeState(isNeedClear isMasked: Bool, tag: Int? = nil) { // Fill or cancel fill for indicators
    let results = pinIndicators.filter { $0.isMasked == isMasked }
    let pinView = isMasked ? results.last : results.first
    pinView?.isMasked = !isMasked
    
    UIView.animate(withDuration: LockerConstants.indicatorDuration, animations: {
      pinView?.backgroundColor = isMasked ? .clear : .white
    }) { _ in
      isMasked ? self.pin = String(self.pin.dropLast()) : self.pincodeChecker(tag ?? 0)
    }
  }
  
  fileprivate func pincodeChecker(_ pinNumber: Int) {
    if pin.count < LockerConstants.maxPinLength { // Check on limit pin
      pin.append("\(pinNumber)") // Append number to pincode
      if pin.count == LockerConstants.maxPinLength { // Check if pincode reached the limit
        switch mode! {
        case .create:
          createMode()
        case .change:
          changeMode()
        case .desactive:
          desactiveMode()
        case .validate:
          validateMode()
        }
      }
    }
  }
  
  // MARK: - Modes
  fileprivate func createMode() {
    if isNeedConfirm {
      isNeedConfirm = false
      reservedPin = pin
      clearView()
      submessageLabel.text = "Confirm your pincode"
    } else {
      confirmPin()
    }
  }
  
  fileprivate func changeMode() {
    pin == savedPin ? precreateSettings () : incorrectPinAnimation()
  }
  
  fileprivate func desactiveMode() {
    pin == savedPin ? removePin() : incorrectPinAnimation()
  }
  
  fileprivate func validateMode() {
    pin == savedPin ? dismiss(animated: true, completion: nil) : incorrectPinAnimation()
  }
  
  fileprivate func removePin() {
    UserDefaults.standard.removeObject(forKey: LockerConstants.kPincode)
    dismiss(animated: true, completion: nil)
  }
  
  fileprivate func confirmPin() {
    if pin == reservedPin {
      savedPin = pin
      dismiss(animated: true, completion: nil)
    } else {
      incorrectPinAnimation()
    }
  }
  
  fileprivate func incorrectPinAnimation() {
    for view in pinIndicators {
      shake(view)
      view.backgroundColor = .clear
    }
    AudioServicesPlayAlertSound(SystemSoundID(kSystemSoundID_Vibrate))
  }
  
  fileprivate func clearView() {
    for view in pinIndicators {
      view.isMasked = false
      pin = ""
      UIView.animate(withDuration: LockerConstants.indicatorDuration, animations: {
        view.backgroundColor = .clear
      })
    }
  }
  
  // MARK: - Animation
  fileprivate func shake(_ view: Indicator) {
    let animation = CAKeyframeAnimation(keyPath: LockerConstants.animationKeyPath)
    animation.timingFunction = CAMediaTimingFunction(name: kCAMediaTimingFunctionLinear)
    animation.duration = LockerConstants.shakeDuration
    animation.values = [-20.0, 20.0, -20.0, 20.0, -10.0, 10.0, -5.0, 5.0, 0.0]
    animation.delegate = self
    view.layer.add(animation, forKey: LockerConstants.shakeAnimation)
  }
  
  // MARK: - Touch ID / Face ID
  fileprivate func checkSensors() {
    guard mode == .validate else {return}
    
    var policy: LAPolicy = .deviceOwnerAuthenticationWithBiometrics // iOS 8+ users with Biometric and Custom (Fallback button) verification
    
    // Depending the iOS version we'll need to choose the policy we are able to use
    if #available(iOS 9.0, *) {
      // iOS 9+ users with Biometric and Passcode verification
      policy = .deviceOwnerAuthentication
    }
    
    var err: NSError?
    // Check if the user is able to use the policy we've selected previously
    guard context.canEvaluatePolicy(policy, error: &err) else {return}
    
    // The user is able to use his/her Touch ID / Face ID 👍
    context.evaluatePolicy(policy, localizedReason: LockerConstants.kLocalizedReason, reply: {  success, error in
      if success {
        self.dismiss(animated: true, completion: nil)
      }
    })
    
  }
  
  // MARK: - Keyboard
  @IBAction func keyboardPressed(_ sender: UIButton) {
    switch sender.tag {
    case LockerConstants.deleteTag:
      indicatorChangeState(isNeedClear: true)
    case LockerConstants.cancelTag:
      clearView()
      dismiss(animated: true, completion: nil)
    default:
      indicatorChangeState(isNeedClear: false, tag: sender.tag)
    }
  }
  
}

// MARK: - CAAnimationDelegate
extension AppLocker: CAAnimationDelegate {
  func animationDidStop(_ anim: CAAnimation, finished flag: Bool) {
    guard flag else {return}
    clearView()
  }
  
}

// MARK: - Present
extension AppLocker {
  // You can set nil for default values
  // Present AppLocker
  class func present(with mode: LockerMode, and config: LockerConfig? = nil) {
    
    if let appLocker = Bundle.main.loadNibNamed(LockerConstants.appLockerNib,
                                                owner: self,
                                                options: nil)?.first as? AppLocker {
      
      appLocker.messageLabel.text = config?.title ?? ""
      
      appLocker.mode = mode
      
      if let isSensorsEnabled = config?.isSensorsEnabled, isSensorsEnabled {
        appLocker.checkSensors()
      }
      
      if let image = config?.image {
        appLocker.photoImageView.image = image
      } else {
        appLocker.photoImageView.isHidden = true
      }
      
      if let subtitle = config?.subtitle {
        appLocker.submessageLabel.text = subtitle
      }
      
      if let color = config?.color {
        appLocker.view.backgroundColor = color
      }      
      UIApplication.shared.keyWindow?.rootViewController?.present(appLocker, animated: true, completion: nil)
    }
  }
  
}

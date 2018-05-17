//
//  AppALConstants.swift
//  AppLocker
//
//  Created by Oleg Ryasnoy on 07.07.17.
//  Copyright © 2017 Oleg Ryasnoy. All rights reserved.
//

import UIKit
import AudioToolbox
import LocalAuthentication

enum ALConstants {
  static let nibName = "AppLocker"
  static let kPincode = "pincode" // Key for saving pincode to UserDefaults
  static let kLocalizedReason = "Unlock with sensor" // Your message when sensors must be shown
  static let duration = 0.3 // Duration of indicator filling
  static let maxPinLength = 4
  
  enum button: Int {
    case delete = 1000
    case cancel = 1001
  }
}

struct ALAppearance { // The structure used to display the controller
  var title: String?
  var subtitle: String?
  var image: UIImage?
  var color: UIColor?
  var isSensorsEnabled: Bool?
}

enum ALMode { // Modes for AppLocker
  case validate
  case change
  case deactive
  case create
}

class AppLocker: UIViewController {
  
  // MARK: - Top view
  @IBOutlet weak var photoImageView: UIImageView!
  @IBOutlet weak var messageLabel: UILabel!
  @IBOutlet weak var submessageLabel: UILabel!
  @IBOutlet var pinIndicators: [Indicator]!
  
  @IBOutlet weak var cancelButton: Button!
  
  // MARK: - Pincode
  fileprivate let context = LAContext()
  fileprivate var pin = "" // Entered pincode
  fileprivate var reservedPin = "" // Reserve pincode for confirm
  fileprivate var isFirstCreationStep = true
  fileprivate var savedPin: String? {
    get {
      return UserDefaults.standard.string(forKey: ALConstants.kPincode)
    }
    set {
      UserDefaults.standard.set(newValue, forKey: ALConstants.kPincode)
    }
  }
  
  fileprivate var mode: ALMode? {
    didSet {
      let mode = self.mode ?? .validate
      switch mode {
      case .create:
        submessageLabel.text = "Create your passcode" // Your submessage for create mode
      case .change:
        submessageLabel.text = "Enter your passcode" // Your submessage for change mode
      case .deactive:
        submessageLabel.text = "Enter your passcode" // Your submessage for deactive mode
      case .validate:
        submessageLabel.text = "Enter your passcode" // Your submessage for validate mode
        cancelButton.isHidden = true
        isFirstCreationStep = false
      }
    }
  }
  
  fileprivate func precreateSettings () { // Precreate settings for change mode
    mode = .create
    clearView()
  }
  
  fileprivate func drawing(isNeedClear: Bool, tag: Int? = nil) { // Fill or cancel fill for indicators
    let results = pinIndicators.filter { $0.isNeedClear == isNeedClear }
    let pinView = isNeedClear ? results.last : results.first
    pinView?.isNeedClear = !isNeedClear
    
    UIView.animate(withDuration: ALConstants.duration, animations: {
      pinView?.backgroundColor = isNeedClear ? .clear : .white
    }) { _ in
      isNeedClear ? self.pin = String(self.pin.dropLast()) : self.pincodeChecker(tag ?? 0)
    }
  }
  
  fileprivate func pincodeChecker(_ pinNumber: Int) {
    if pin.count < ALConstants.maxPinLength {
      pin.append("\(pinNumber)")
      if pin.count == ALConstants.maxPinLength {
        switch mode ?? .validate {
        case .create:
          createModeAction()
        case .change:
          changeModeAction()
        case .deactive:
          deactiveModeAction()
        case .validate:
          validateModeAction()
        }
      }
    }
  }
  
  // MARK: - Modes
  fileprivate func createModeAction() {
    if isFirstCreationStep {
      isFirstCreationStep = false
      reservedPin = pin
      clearView()
      submessageLabel.text = "Confirm your pincode"
    } else {
      confirmPin()
    }
  }
  
  fileprivate func changeModeAction() {
    pin == savedPin ? precreateSettings() : incorrectPinAnimation()
  }
  
  fileprivate func deactiveModeAction() {
    pin == savedPin ? removePin() : incorrectPinAnimation()
  }
  
  fileprivate func validateModeAction() {
    pin == savedPin ? dismiss(animated: true, completion: nil) : incorrectPinAnimation()
  }
  
  fileprivate func removePin() {
    UserDefaults.standard.removeObject(forKey: ALConstants.kPincode)
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
    pinIndicators.forEach { view in
      view.shake(delegate: self)
      view.backgroundColor = .clear
    }
    AudioServicesPlayAlertSound(SystemSoundID(kSystemSoundID_Vibrate))
  }
  
  fileprivate func clearView() {
    pin = ""
    pinIndicators.forEach { view in
      view.isNeedClear = false
      UIView.animate(withDuration: ALConstants.duration, animations: {
        view.backgroundColor = .clear
      })
    }
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
    context.evaluatePolicy(policy, localizedReason: ALConstants.kLocalizedReason, reply: {  success, error in
      if success {
        self.dismiss(animated: true, completion: nil)
      }
    })
  }
  
  // MARK: - Keyboard
  @IBAction func keyboardPressed(_ sender: UIButton) {
    switch sender.tag {
    case ALConstants.button.delete.rawValue:
      drawing(isNeedClear: true)
    case ALConstants.button.cancel.rawValue:
      clearView()
      dismiss(animated: true, completion: nil)
    default:
      drawing(isNeedClear: false, tag: sender.tag)
    }
  }
  
}

// MARK: - CAAnimationDelegate
extension AppLocker: CAAnimationDelegate {
  func animationDidStop(_ anim: CAAnimation, finished flag: Bool) {
    clearView()
  }
}

// MARK: - Present
extension AppLocker {
  // Present AppLocker
  class func present(with mode: ALMode, and config: ALAppearance? = nil) {
    guard let root = UIApplication.shared.keyWindow?.rootViewController,
      let locker = Bundle.main.loadNibNamed(ALConstants.nibName, owner: self, options: nil)?.first as? AppLocker else {
        return
    }
    locker.messageLabel.text = config?.title ?? ""
    locker.submessageLabel.text = config?.subtitle ?? ""
    locker.view.backgroundColor = config?.color ?? .black
    locker.mode = mode
    
    if config?.isSensorsEnabled ?? false {
      locker.checkSensors()
    }
    
    if let image = config?.image {
      locker.photoImageView.image = image
    } else {
      locker.photoImageView.isHidden = true
    }
    
    root.present(locker, animated: true, completion: nil)
  }
}

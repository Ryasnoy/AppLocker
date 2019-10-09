![](https://github.com/ryasnoy/AppLocker/raw/master/AppLockerLogo.png)

![Swift](https://img.shields.io/badge/Swift-4.0-orange.svg)
[![License](https://img.shields.io/badge/license-MIT-blue.svg?style=flat)](http://mit-license.org)
[![Platform](http://img.shields.io/badge/platform-ios-lightgrey.svg?style=flat)](https://developer.apple.com/resources/)
[![Twitter](https://img.shields.io/badge/twitter-@ryasn0y-blue.svg?maxAge=2592000)](http://twitter.com/ryasn0y)

# AppLocker
Very simple locker for your `iOS` application

### Preview
![](https://github.com/ryasnoy/AppLocker/raw/master/preview.png)

### Modes
```swift
enum ALMode { // Modes for AppLocker
  case validate
  case change
  case deactive
  case create
}
```

### Configuration
```swift
struct ALOptions { // The structure used to display the controller
  var title: String?
  var subtitle: String?
  var image: UIImage?
  var color: UIColor?
  var isSensorsEnabled: Bool?
}
```


### Example
#### Simple call of controller
```swift
AppLocker.present(with: .create) // validate, deactive, change
```
#### Calling the controller with configuration
```swift
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

    AppLocker.present(with: mode, and: appearance, over: self)
```

## Requirements
AppLocker is written in Swift 3. iOS 8.0+ Required

## Installation
Just move the `Source` folder to your project

## CocoaPods
```
  pod 'AppLocker'
```
For iOS 8.0
```
  pod 'AppLocker', ~> '1.0.1'
 ```

## Author

Oleg Ryasnoy, ryasnoy.oleg@gmail.com

Telegram: https://t.me/ryasnoy

## License

AppLocker is available under the MIT license. See the LICENSE file for more info.

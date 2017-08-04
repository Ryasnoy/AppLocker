![](https://github.com/ryasnoy/AppLocker/raw/master/AppLockerLogo.png)

![Swift](https://img.shields.io/badge/Swift-3.0-orange.svg)
[![License](https://img.shields.io/badge/license-MIT-blue.svg?style=flat)](http://mit-license.org)
[![Platform](http://img.shields.io/badge/platform-ios-lightgrey.svg?style=flat)](https://developer.apple.com/resources/)
[![Twitter](https://img.shields.io/badge/twitter-@ryasn0y-blue.svg?maxAge=2592000)](http://twitter.com/ryasn0y)

# AppLocker
Very simple locker for your `iOS` application

### Preview
![](https://github.com/ryasnoy/AppLocker/raw/master/preview.png)

### Modes
```swift
enum LockerMode { // Modes for AppLocker
  case validate
  case change
  case desactive
  case create
}
```

### Configuration
```swift
struct LockerConfig { // The structure used to display the controller
  var title: String?
  var subtitle: String?
  var image: UIImage?
  var color: UIColor?
}
```


### Example
#### Simple call of controller
```swift
AppLocker.present(with: .create) // validate, desactive, change
```
#### Calling the controller with configuration
```swift
var config = LockerConfig()
    config.image = UIImage(named: "face")!
    config.title = "Devios Ryasnoy"
    config.color = .black
    config.subtitle = "Hello World"
    
    AppLocker.present(with: .create, and: config)
```

## Requirements
AppLocker is written in Swift 3. iOS 8.0+ Required

## Installation
Just move the `Source` folder to your project

## Author

Oleg Ryasnoy, ryasnoy.oleg@gmail.com

Telegram: https://t.me/ryasnoy

## License

AppLocker is available under the MIT license. See the LICENSE file for more info.

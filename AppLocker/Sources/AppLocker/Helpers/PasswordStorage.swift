//
//  PasswordStorage.swift
//  
//
//  Created by Oleh Riasnoi on 26.05.2021.
//

import Foundation
import Keychainer

@propertyWrapper
struct PasswordStorage<Value> {
    
    let key: String
    let defaultValue: Value
    var container = Keychainer(serviceName: "\(AppLocker.self)")

    var wrappedValue: Value {
        get {
            return container.string(forKey: key) as? Value ?? defaultValue
        }
        set {
            guard let newValue = newValue as? String else {
                return
            }
            container.set(newValue, forKey: key)
        }
    }
}

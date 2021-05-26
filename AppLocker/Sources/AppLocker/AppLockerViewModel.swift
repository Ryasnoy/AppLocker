//
//  AppLockerViewModel.swift
//  
//
//  Created by Oleh Riasnoi on 26.05.2021.
//

import Foundation
import Keychainer

final class AppLockerViewModel: ObservableObject {
    
    let headerConfiguration: HeaderConfiguration?
    let appLockerConfiguration: AppLockerConfiguration?
    
    private let keychainer = Keychainer(serviceName: "\(AppLocker.self)")
    
    var code: String? {
        get {
            return keychainer.string(forKey: Keychainer.codeKey)
        }
        set {
            guard let newValue = newValue else { return }
            keychainer.set(newValue, forKey: Keychainer.codeKey)
        }
    }
    
    
    init(headerConfiguration: HeaderConfiguration? = nil,
         appLockerConfiguration: AppLockerConfiguration? = nil) {
        self.headerConfiguration = headerConfiguration
        self.appLockerConfiguration = appLockerConfiguration    
    }

}

private extension Keychainer {
    
    static let codeKey = "codeKey"
    
}

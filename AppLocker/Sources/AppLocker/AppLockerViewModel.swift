//
//  AppLockerViewModel.swift
//  
//
//  Created by Oleh Riasnoi on 26.05.2021.
//

import Foundation

final class AppLockerViewModel: ObservableObject {
    
    let headerConfiguration: HeaderConfiguration?
    let appLockerConfiguration: AppLockerConfiguration?
    
    private let keychainer = Keychainer(serviceName: "\(AppLocker.self)")
    
    @PasswordStorage(key: "password", defaultValue: nil)
    var password: String?
    
    init(headerConfiguration: HeaderConfiguration? = nil,
         appLockerConfiguration: AppLockerConfiguration? = nil) {
        self.headerConfiguration = headerConfiguration
        self.appLockerConfiguration = appLockerConfiguration
    }

}

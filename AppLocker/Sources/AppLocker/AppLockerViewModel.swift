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
    
    init(headerConfiguration: HeaderConfiguration? = nil,
         appLockerConfiguration: AppLockerConfiguration? = nil) {
        self.headerConfiguration = headerConfiguration
        self.appLockerConfiguration = appLockerConfiguration
    }
}

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
    
    @PasswordStorage(key: "password", defaultValue: nil)
    private var password: String?
    
    private lazy var currentPasswordInput = "" {
        didSet {
            print("Current password:", currentPasswordInput)
        }
    }
    
    init(headerConfiguration: HeaderConfiguration? = nil,
         appLockerConfiguration: AppLockerConfiguration? = nil) {
        self.headerConfiguration = headerConfiguration
        self.appLockerConfiguration = appLockerConfiguration
    }

    private func handleSystem(action: NPSystemAction) {
        switch action {
        case .cancel:
            if !currentPasswordInput.isEmpty {
                currentPasswordInput.removeLast()
            }
        case .delete:
            currentPasswordInput = ""
        }
    }
    
}

// MARK: - Interactions
extension AppLockerViewModel {
    
    func handleKeyboard(output: NPAction) {
        switch output {
        case .number(let number):
            currentPasswordInput.append(number.description)
        case .system(let action): handleSystem(action: action)
        }
    }
    
}

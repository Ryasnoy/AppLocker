//
//  AppLockerViewModel.swift
//  
//
//  Created by Oleh Riasnoi on 26.05.2021.
//

import Foundation

final class AppLockerViewModel: ObservableObject {
    
    let headerConfiguration: HeaderConfiguration?
    let appLockerConfiguration: AppLockerConfiguration
    
    @PasswordStorage(key: "password", defaultValue: nil)
    private var password: String?
    
    private lazy var currentInputPassword = "" {
        didSet {
            print("Current password:", currentInputPassword)
            currentCodeLength = currentInputPassword.count
        }
    }
    
    @Published var currentCodeLength: Int = 0
    
    var codeLength: Int {
        appLockerConfiguration.codeLength
    }
    
    let moderator: Moderator
    
    init(headerConfiguration: HeaderConfiguration? = nil,
         appLockerConfiguration: AppLockerConfiguration,
         appLockerMode: AppLockerMode) {
        self.headerConfiguration = headerConfiguration
        self.appLockerConfiguration = appLockerConfiguration
        moderator = Mode.create.getModerator()//appLockerMode.mode.getModerator()
    }
    
}

// MARK: - Interactions
extension AppLockerViewModel {
    
    func handleKeyboard(output: NPAction) {
        switch output {
        case .number(let number):
            updateCurrentInputPassword(with: number)
        case .system(let action):
            handleSystem(action: action)
        }
    }
    
}

// MARK: - Private
private extension AppLockerViewModel {
    
    func handleSystem(action: NPSystemAction) {
        switch action {
        case .cancel:
            makeCancelAction()
        case .delete:
            currentInputPassword = ""
        }
    }
    
    func makeCancelAction() {
        if !currentInputPassword.isEmpty {
            currentInputPassword.removeLast()
        }
    }
    
    func updateCurrentInputPassword(with number: Int) {
        if currentCodeLength < codeLength {
            currentInputPassword.append(number.description)
        }        
        (moderator as! CreatePassword).canBeSaved(with: currentCodeLength) {
            print(self.currentInputPassword, " Will be saved")
        }
    }
    
}

// MARK: - Modes
private extension AppLockerViewModel {
    
}

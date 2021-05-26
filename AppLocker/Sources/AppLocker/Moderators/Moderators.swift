//
//  Moderators.swift
//  
//
//  Created by Oleh Riasnoi on 26.05.2021.
//

import Foundation

protocol Moderator {}

class CreatePassword: Moderator {
    
    var isFirstStep = true
    let codeLength: Int = 4
    
    func canBeSaved(with currentInputLength: Int, then: @escaping () -> Void) {
        let isAllowedLength = codeLength == currentInputLength
        if isAllowedLength {
            if isFirstStep {
                isFirstStep.toggle()
            } else {
                then()
            }
        }
    }
    
}

struct ValidatePassword: Moderator {
    
}

struct ChangePassword: Moderator {
    
}

struct RemovePassword: Moderator {
    
}

extension Mode {
    
    func getModerator() -> Moderator {
        switch self {
        case .create:
            return CreatePassword()
        case .validate:
            return ValidatePassword()
        case .change:
            return ChangePassword()
        case .deactive:
            return RemovePassword()
        }
    }
    
}

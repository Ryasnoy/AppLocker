//
//  Moderators.swift
//  
//
//  Created by Oleh Riasnoi on 26.05.2021.
//

import Foundation

protocol Moderator {}

struct CreatePassword: Moderator {
    
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

//
//  AppLockerMode.swift
//  
//
//  Created by Oleh Riasnoi on 26.05.2021.
//

import Foundation

public enum Mode {
    
    case create
    case validate
    case change
    case deactive

}

public struct AppLockerMode {
    
    let mode: Mode
    let message: String
    
    
    public static let `default` = AppLockerMode(mode: .validate, message: "")
}

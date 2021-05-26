//
//  Configurations.swift
//  
//
//  Created by Oleh Riasnoi on 26.05.2021.
//

import Foundation
import SwiftUI

public struct HeaderConfiguration {
    
    public let image: Image?
    public let title: String?
    public let subtitle: String?

}

public struct AppLockerConfiguration {
    
    public let backgroundColor: Color?
    public let buttonBorderColor: Color?
    
    public let isSensorsEnabled: Bool
    public let codeLength: Int
    
}

public struct CustomHeader<Content: View> {
    
    public let view: Content
    
}

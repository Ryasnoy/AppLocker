//
//  View+AnyView.swift
//  
//
//  Created by Oleh Riasnoi on 26.05.2021.
//

import SwiftUI

public extension View {
    
    func eraseToAnyView() -> AnyView {
        AnyView(self)
    }
    
}

//
//  Pad.swift
//  
//
//  Created by Oleh Riasnoi on 26.05.2021.
//

import SwiftUI

struct Pad: View {
    
    let data: String

    var body: some View {
        Text(data)
            .frame(width: 75, height: 75)
            .background(Circle().strokeBorder())
    }

}

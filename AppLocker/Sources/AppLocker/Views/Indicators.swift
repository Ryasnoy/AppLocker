//
//  Indicators.swift
//  
//
//  Created by Oleh Riasnoi on 26.05.2021.
//

import SwiftUI

struct Indicators: View {
    
    let codeLength: Int
    let currentCodeLength: Int
    
    var body: some View {
        HStack {
            ForEach(0..<codeLength, id: \.self) { i in
                circle(i)
            }
        }
    }
    
    @ViewBuilder
    func circle(_ i: Int) -> some View {
        if currentCodeLength <= i {
            Circle()
                .stroke()
                .frame(width: 16, height: 16)
        } else {
            Circle()
                .frame(width: 16, height: 16)
        }
    }
    
}

struct Indicators_Preview: PreviewProvider {
    
    static var previews: some View {
        Indicators(codeLength: 6, currentCodeLength: 2)
    }
    
}

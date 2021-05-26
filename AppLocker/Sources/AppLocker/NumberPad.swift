//
//  NumberPad.swift
//  
//
//  Created by Oleh Riasnoi on 26.05.2021.
//

import SwiftUI

struct NumberPad: View {
    
    let dataSource = [
        [1, 2, 3],
        [4, 5, 6],
        [7, 8, 9]
    ]
    
    var body: some View {
        VStack(spacing: 8) {
            ForEach(dataSource, id: \.self) { data in
                row(with: data)
            }
        }
    }
    
    func row(with numbers: [Int]) -> some View {
        HStack(spacing: 8) {
            ForEach(numbers, id: \.self) { number in
                Text(number.description)
                    .frame(width: 100, height: 100)
                    .background(Circle().strokeBorder())
            }
        }
    }
}

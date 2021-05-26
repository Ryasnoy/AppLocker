//
//  NumberPad.swift
//  
//
//  Created by Oleh Riasnoi on 26.05.2021.
//

import SwiftUI

struct NumberPad: View {
    
    let spacing: CGFloat = 16
    
    let data = [
        ["1", "2", "3"],
        ["4", "5", "6"],
        ["7", "8", "9"],
        ["Cancel", "0", "Delete"]
    ]
    
    var body: some View {
        VStack(spacing: spacing) {
            ForEach(data, id: \.self) { rowData in
                row(with: rowData)
            }
        }
    }
    
    func row(with rowData: [String]) -> some View {
        HStack(spacing: spacing) {
            ForEach(rowData, id: \.self) { data in
                Pad(data: data)
            }
        }
    }
}

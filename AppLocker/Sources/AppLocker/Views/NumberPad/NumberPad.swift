//
//  NumberPad.swift
//  
//
//  Created by Oleh Riasnoi on 26.05.2021.
//

import SwiftUI

struct NumberPad: View {
    
    let spacing: CGFloat = 16
    
    let output: (String) -> ()
    
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
            ForEach(rowData, id: \.self) { text in
                pad(text)
            }
        }
    }
    
    func pad(_ text: String) -> some View {
        Pad(data: text)
            .contentShape(Circle())
            .onTapGesture {
                output(text)
            }
    }
}

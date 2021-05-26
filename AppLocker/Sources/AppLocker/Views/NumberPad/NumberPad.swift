//
//  NumberPad.swift
//  
//
//  Created by Oleh Riasnoi on 26.05.2021.
//

import SwiftUI

enum NPAction: Hashable {
    
    case number(_ num: Int)
    case system(action: NPSystemAction)
    
    fileprivate var description: String {
        switch self {
        case .number(let number):
            return String(number)
        case .system(let action):
            return action.description
        }
    }
}

enum NPSystemAction: String {
    
    case cancel
    case delete
    
    fileprivate var description: String {
        NSLocalizedString(rawValue.capitalized, comment: "")
    }
    
}

struct NumberPad: View {
    
    let spacing: CGFloat = 16
    
    let output: (NPAction) -> ()
    
    let data: [[NPAction]] = [
        [.number(1), .number(2), .number(3)],
        [.number(4), .number(5), .number(6)],
        [.number(7), .number(8), .number(9)],
        [.system(action: .cancel), .number(0), .system(action: .delete)],
    ]
    
    var body: some View {
        VStack(spacing: spacing) {
            ForEach(data, id: \.self) { rowData in
                row(with: rowData)
            }
        }
    }
    
    func row(with rowData: [NPAction]) -> some View {
        HStack(spacing: spacing) {
            ForEach(rowData, id: \.self) { text in
                pad(text)
            }
        }
    }
    
    func pad(_ action: NPAction) -> some View {
        Pad(data: action.description)
            .contentShape(Circle())
            .onTapGesture {
                output(action)
            }
    }
}

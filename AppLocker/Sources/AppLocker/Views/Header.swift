//
//  Header.swift
//  
//
//  Created by Oleh Riasnoi on 26.05.2021.
//

import SwiftUI

struct Header: View {
    
    let configuration: HeaderConfiguration?
    
    init(configuration: HeaderConfiguration?) {
        self.configuration = configuration
    }
    
    var body: some View {
        VStack {
            picture
            txtTitle
        }
    }
    
    @ViewBuilder
    var picture: some View {
        if let image = configuration?.image {
            image
        }
    }
    
    @ViewBuilder
    var txtTitle: some View {
        if let title = configuration?.title {
            Text(title)
        }
    }
    
}

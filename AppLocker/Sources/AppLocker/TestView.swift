//
//  SwiftUIView.swift
//  
//
//  Created by Oleh Riasnoi on 26.05.2021.
//

import SwiftUI

struct TestView: View {
    
    var body: some View {
//        AppLocker(headerConfiguration: .init(image: nil,
//                                             title: "Hello",
//                                             subtitle: nil),
//                  appLockerConfiguration: .init(backgroundColor: Color.blue,
//                                                buttonBorderColor: Color.orange,
//                                                isSensorsEnabled: true,
//                                                codeLength: 4))
        
        AppLocker(.init(view: Rectangle()
                            .foregroundColor(.yellow)
                            .eraseToAnyView()))
    }
    
}

struct TestView_Preview: PreviewProvider {
    static var previews: some View {
        TestView()
    }
}

import SwiftUI

public struct AppLocker: View {
    
    @ObservedObject var viewModel: AppLockerViewModel
    
    var header: CustomHeader<AnyView>?
    
    public init(headerConfiguration: HeaderConfiguration? = nil,
                appLockerConfiguration: AppLockerConfiguration? = nil,
                mode: AppLockerMode = .default) {
        viewModel = .init(headerConfiguration: headerConfiguration,
                          appLockerConfiguration: appLockerConfiguration)
    }
    
    public init(_ header: CustomHeader<AnyView>, mode: AppLockerMode = .default) {
        viewModel = .init()
        self.header = header
    }
    
    public var body: some View {
        ZStack {
            background
            GeometryReader { geometry in
                VStack {
                    header(geometry)
                    NumberPad(output: viewModel.handleKeyboard)
                }
                .frame(width: geometry.size.width)
            }
        }
    }
    
    var background: some View {
        viewModel
            .appLockerConfiguration?
            .backgroundColor
            .edgesIgnoringSafeArea(.all)
    }
    
}

// MARK: - Header
private extension AppLocker {
        
    func header(_ geometry: GeometryProxy) -> AnyView {
        if let header = header {
            return header.view
        } else {
            return Header(configuration: viewModel.headerConfiguration)
                .frame(height: geometry.size.height * 0.33)
                .eraseToAnyView()
        }
    }
    
}

struct AppLocker_Preview: PreviewProvider {
    
    static var previews: some View {
        AppLocker()
    }
    
}

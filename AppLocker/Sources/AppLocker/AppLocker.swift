import SwiftUI

public struct AppLocker: View {
    
    private let headerConfiguration: HeaderConfiguration?
    private let appLockerConfiguration: AppLockerConfiguration?
    
    public init(headerConfiguration: HeaderConfiguration? = nil,
                appLockerConfiguration: AppLockerConfiguration? = nil) {
        self.headerConfiguration = headerConfiguration
        self.appLockerConfiguration = appLockerConfiguration
    }
    
    public var body: some View {
        GeometryReader { geometry in
            VStack {
                header(geometry)
                NumberPad()
            }
            .frame(width: geometry.size.width)
        }
    }
    
}

// MARK: - Header
private extension AppLocker {
    
    func header(_ geometry: GeometryProxy) -> some View {
        Header(configuration: headerConfiguration)
            .frame(height: geometry.size.height * 0.33)
    }
    
}

struct AppLocker_Preview: PreviewProvider {
    
    static var previews: some View {
        AppLocker()
    }
    
}

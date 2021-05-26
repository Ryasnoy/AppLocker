import SwiftUI

struct AppLocker: View {
    
    var body: some View {
        VStack {
            Header()
            NumberPad()
        }
    }
    
}

struct AppLocker_Preview: PreviewProvider {
    
    static var previews: some View {
        AppLocker()
    }
    
}

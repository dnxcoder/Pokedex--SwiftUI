import SwiftUI

struct ContentView: View {
    @AppStorage("isLoggedIn") private var isLoggedIn = false

    var body: some View {
        if isLoggedIn {
            AppNavigationView()
        } else {
            NavigationStack {
                WelcomeView()
            }
        }
    }
}

#Preview {
    ContentView()
}

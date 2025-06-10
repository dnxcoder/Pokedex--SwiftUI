import SwiftUI

struct WelcomeView: View {
    var body: some View {
        VStack(spacing: 20) {
            Text("Welcome to Pokédex")
                .font(.largeTitle)
                .multilineTextAlignment(.center)
            NavigationLink("Login", destination: LoginView())
                .buttonStyle(.borderedProminent)
        }
        .padding()
        .navigationTitle("Welcome")
    }
}

#Preview {
    NavigationStack { WelcomeView() }
}

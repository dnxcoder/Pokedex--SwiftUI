import SwiftUI

struct LoginView: View {
    @AppStorage("isLoggedIn") private var isLoggedIn = false
    @State private var username = ""
    @State private var password = ""
    @State private var showError = false

    var body: some View {
        VStack(spacing: 16) {
            TextField("Username", text: $username)
                .textFieldStyle(.roundedBorder)
            SecureField("Password", text: $password)
                .textFieldStyle(.roundedBorder)
            if showError {
                Text("Invalid credentials")
                    .foregroundColor(.red)
            }
            Button("Login") {
                if username == "admin" && password == "admin" {
                    isLoggedIn = true
                } else {
                    showError = true
                }
            }
            .buttonStyle(.borderedProminent)
        }
        .padding()
        .navigationTitle("Login")
    }
}

#Preview {
    NavigationStack { LoginView() }
}

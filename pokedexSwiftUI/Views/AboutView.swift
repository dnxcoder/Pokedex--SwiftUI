import SwiftUI

struct AboutView: View {
    @AppStorage("isLoggedIn") private var isLoggedIn = false

    var body: some View {
        ScrollView {
            VStack(alignment: .leading, spacing: 12) {
                Text("About")
                    .font(.title2)
                    .bold()
                Text("This app showcases Pokémon fetched from PokeAPI. Swipe through the tabs to explore the Pokédex, view random Pokémon and learn about the different types.")
                Text("Have fun catching them all!")
                Button("Logout") {
                    isLoggedIn = false
                }
                .buttonStyle(.borderedProminent)
                .padding(.top, 20)
            }
            .padding()
        }
        .navigationTitle("About")

    }
}

#Preview {
    NavigationStack {
        AboutView()
    }
}

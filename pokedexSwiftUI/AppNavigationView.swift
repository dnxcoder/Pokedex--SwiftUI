import SwiftUI

struct AppNavigationView: View {
    var body: some View {
        NavigationStack {
            HomeView()
                .navigationDestination(for: Pokemon.self) { pokemon in
                    PokemonDetailView(pokemon: pokemon)
                }
        }
    }
}

#Preview {
    AppNavigationView()
}

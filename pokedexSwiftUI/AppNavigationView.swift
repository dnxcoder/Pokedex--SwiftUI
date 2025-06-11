import SwiftUI

struct AppNavigationView: View {
    var body: some View {
        TabView {
            NavigationStack {
                HomeView()
                    .navigationDestination(for: Pokemon.self) { pokemon in
                        PokemonDetailView(pokemon: pokemon)
                    }
            }
            .tabItem { Label("Pokédex", systemImage: "list.bullet") }

            NavigationStack {
                RandomPokemonView()
                    .navigationDestination(for: Pokemon.self) { pokemon in
                        PokemonDetailView(pokemon: pokemon)
                    }
            }
            .tabItem { Label("Random", systemImage: "shuffle") }

            NavigationStack {
                TypesView()
            }
            .tabItem { Label("Types", systemImage: "square.grid.2x2") }

            NavigationStack {
                CarouselView()
                    .navigationDestination(for: Pokemon.self) { pokemon in
                        PokemonDetailView(pokemon: pokemon)
                    }
            }
            .tabItem { Label("Carousel", systemImage: "rectangle.fill.on.rectangle.fill") }

            NavigationStack {
                AboutView()
            }
            .tabItem { Label("About", systemImage: "info.circle") }
        }
    }
}

#Preview {
    AppNavigationView()
}

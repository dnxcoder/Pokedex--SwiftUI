import SwiftUI

struct RandomPokemonView: View {
    @StateObject private var viewModel = RandomPokemonViewModel()

    var body: some View {
        VStack(spacing: 16) {
            if let pokemon = viewModel.pokemon {
                NavigationLink(value: pokemon) {
                    VStack {
                        AsyncImage(url: pokemon.imageURL) { image in
                            image.resizable()
                                .aspectRatio(contentMode: .fit)
                        } placeholder: {
                            ProgressView()
                        }
                        .frame(width: 120, height: 120)
                        Text(pokemon.name)
                            .font(.headline)
                    }
                }
            } else {
                Text("Tap the button to load a Pokémon")
            }

            Button("Load Random Pokémon") {
                Task { await viewModel.loadRandomPokemon() }
            }
            .buttonStyle(.borderedProminent)
        }
        .padding()
        .navigationTitle("Random")
        .task {
            if viewModel.pokemon == nil {
                await viewModel.loadRandomPokemon()
            }
        }
    }
}

#Preview {
    NavigationStack {
        RandomPokemonView()
    }
}

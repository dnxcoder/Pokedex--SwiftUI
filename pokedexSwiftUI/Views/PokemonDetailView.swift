import SwiftUI
import AVFoundation

struct PokemonDetailView: View {
    let pokemon: Pokemon
    @State private var player: AVPlayer?

    var body: some View {
        ScrollView {
            VStack(spacing: 16) {
                NavigationLink(destination: PokemonTriviaView(pokemon: pokemon)) {
                    AsyncImage(url: pokemon.imageURL) { image in
                        image.resizable()
                            .aspectRatio(contentMode: .fit)
                    } placeholder: {
                        ProgressView()
                    }
                    .frame(width: 150, height: 150)
                }

                VStack(alignment: .leading, spacing: 8) {
                    Text("ID: \(pokemon.id)")
                    Text("Name: \(pokemon.name)")
                    Text("Types: \(pokemon.types.joined(separator: ", "))")
                    Text("Height: \(pokemon.height)")
                    Text("Weight: \(pokemon.weight)")
                    Text("Base Experience: \(pokemon.baseExperience)")
                    Text("Abilities: \(pokemon.abilities.joined(separator: ", "))")
                }
                .frame(maxWidth: .infinity, alignment: .leading)

                Button("Tocar Cry") {
                    playCry()
                }
                .padding(.top, 16)
            }
            .padding()
        }
        .navigationTitle(pokemon.name)
    }

    private func playCry() {
        let item = AVPlayerItem(url: pokemon.cryURL)
        player = AVPlayer(playerItem: item)
        player?.play()
    }
}

#Preview {
    PokemonDetailView(pokemon: Pokemon(id: 1, name: "Bulbasaur", types: ["grass"], height: 7, weight: 69, baseExperience: 64, abilities: ["overgrow"]))
}

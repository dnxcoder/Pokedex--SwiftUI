import SwiftUI

struct PokemonTriviaView: View {
    let pokemon: Pokemon
    
    private let trivia: [Int: String] = [
        1: "Bulbasaur is known to be both a plant and an animal. Its plant seed grows progressively larger as it absorbs nutrients.",
        4: "Charmander's tail flame indicates its life force. If it is healthy, the flame burns brightly.",
        7: "Squirtle's shell is not merely used for protection. The shell's rounded shape and the grooves on its surface help minimize resistance in water." 
    ]
    
    var body: some View {
        ScrollView {
            VStack(alignment: .leading, spacing: 16) {
                Text(pokemon.name)
                    .font(.title)
                    .bold()
                Text(trivia[pokemon.id] ?? "No trivia available for this Pokémon.")
                    .font(.body)
            }
            .padding()
        }
        .navigationTitle("Trivia")
    }
}

#Preview {
    PokemonTriviaView(pokemon: Pokemon(id: 1, name: "Bulbasaur", types: ["grass"], height: 7, weight: 69, baseExperience: 64, abilities: ["overgrow"]))
}

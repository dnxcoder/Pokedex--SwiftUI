import Foundation

@MainActor
class PokedexViewModel: ObservableObject {
    @Published var pokemon: [Pokemon] = []

    func fetchPokemon() async {
        guard let url = URL(string: "https://pokeapi.co/api/v2/pokemon?limit=151") else { return }
        do {
            let (data, _) = try await URLSession.shared.data(from: url)
            let list = try JSONDecoder().decode(PokemonList.self, from: data)
            pokemon = list.results.enumerated().compactMap { index, entry in
                let parts = entry.url.split(separator: "/")
                let idString = parts.last ?? "0"
                let id = Int(idString) ?? index + 1
                return Pokemon(id: id, name: entry.name.capitalized)
            }
        } catch {
            print("Failed to fetch Pokémon: \(error)")
        }
    }
}

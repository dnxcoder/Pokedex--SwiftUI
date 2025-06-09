import Foundation

struct PokemonDetail: Decodable {
    struct TypeEntry: Decodable {
        struct Info: Decodable { let name: String }
        let type: Info
    }
    struct AbilityEntry: Decodable {
        struct Info: Decodable { let name: String }
        let ability: Info
    }
    let id: Int
    let name: String
    let types: [TypeEntry]
    let height: Int
    let weight: Int
    let base_experience: Int
    let abilities: [AbilityEntry]
}

@MainActor
class PokedexViewModel: ObservableObject {
    @Published var pokemon: [Pokemon] = []

    func fetchPokemon() async {
        guard let url = URL(string: "https://pokeapi.co/api/v2/pokemon?limit=151") else { return }
        do {
            let (data, _) = try await URLSession.shared.data(from: url)
            let list = try JSONDecoder().decode(PokemonList.self, from: data)
            var loaded: [Pokemon] = []
            for entry in list.results {
                guard let detailURL = URL(string: entry.url) else { continue }
                let (dData, _) = try await URLSession.shared.data(from: detailURL)
                let detail = try JSONDecoder().decode(PokemonDetail.self, from: dData)
                let types = detail.types.map { $0.type.name }
                let abilities = detail.abilities.map { $0.ability.name }
                let pokemon = Pokemon(
                    id: detail.id,
                    name: detail.name.capitalized,
                    types: types,
                    height: detail.height,
                    weight: detail.weight,
                    baseExperience: detail.base_experience,
                    abilities: abilities
                )
                loaded.append(pokemon)
            }
            pokemon = loaded.sorted { $0.id < $1.id }
        } catch {
            print("Failed to fetch Pokémon: \(error)")
        }
    }
}

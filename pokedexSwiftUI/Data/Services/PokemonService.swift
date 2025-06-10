import Foundation

class PokemonService {
    func fetchPokemonEntries() async throws -> [PokemonEntry] {
        guard let url = URL(string: "https://pokeapi.co/api/v2/pokemon?limit=151") else {
            return []
        }
        let (data, _) = try await URLSession.shared.data(from: url)
        let list = try JSONDecoder().decode(PokemonList.self, from: data)
        return list.results
    }

    func fetchDetail(for entry: PokemonEntry) async throws -> Pokemon {
        guard let url = URL(string: entry.url) else { throw URLError(.badURL) }
        let (data, _) = try await URLSession.shared.data(from: url)
        let detail = try JSONDecoder().decode(PokemonDetail.self, from: data)
        let types = detail.types.map { $0.type.name }
        let abilities = detail.abilities.map { $0.ability.name }
        return Pokemon(
            id: detail.id,
            name: detail.name.capitalized,
            types: types,
            height: detail.height,
            weight: detail.weight,
            baseExperience: detail.base_experience,
            abilities: abilities
        )
    }

    func fetchDetail(id: Int) async throws -> Pokemon {
        guard let url = URL(string: "https://pokeapi.co/api/v2/pokemon/\(id)") else {
            throw URLError(.badURL)
        }
        let (data, _) = try await URLSession.shared.data(from: url)
        let detail = try JSONDecoder().decode(PokemonDetail.self, from: data)
        let types = detail.types.map { $0.type.name }
        let abilities = detail.abilities.map { $0.ability.name }
        return Pokemon(
            id: detail.id,
            name: detail.name.capitalized,
            types: types,
            height: detail.height,
            weight: detail.weight,
            baseExperience: detail.base_experience,
            abilities: abilities
        )
    }
}

import Foundation

class PokemonRepositoryImpl: PokemonRepository {
    private let service: PokemonService

    init(service: PokemonService = PokemonService()) {
        self.service = service
    }

    func fetchPokemonList() async throws -> [Pokemon] {
        let entries = try await service.fetchPokemonEntries()
        var list: [Pokemon] = []
        for entry in entries {
            let pokemon = try await service.fetchDetail(for: entry)
            list.append(pokemon)
        }
        return list.sorted { $0.id < $1.id }
    }

    func fetchPokemon(id: Int) async throws -> Pokemon {
        try await service.fetchDetail(id: id)
    }
}

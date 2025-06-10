struct FetchPokemonByIDUseCase {
    let repository: PokemonRepository

    func execute(id: Int) async throws -> Pokemon {
        try await repository.fetchPokemon(id: id)
    }
}

protocol PokemonRepository {
    func fetchPokemonList() async throws -> [Pokemon]
}

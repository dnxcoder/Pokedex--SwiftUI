protocol PokemonRepository {
    func fetchPokemonList() async throws -> [Pokemon]
    func fetchPokemon(id: Int) async throws -> Pokemon
}

import Foundation

@MainActor
class PokedexViewModel: ObservableObject {
    @Published var pokemon: [Pokemon] = []
    private let fetchPokemonUseCase: FetchPokemonListUseCase

    init(fetchPokemonUseCase: FetchPokemonListUseCase = FetchPokemonListUseCase(repository: PokemonRepositoryImpl())) {
        self.fetchPokemonUseCase = fetchPokemonUseCase
    }

    func fetchPokemon() async {
        do {
            pokemon = try await fetchPokemonUseCase.execute()
        } catch {
            print("Failed to fetch Pokémon: \(error)")
        }
    }
}

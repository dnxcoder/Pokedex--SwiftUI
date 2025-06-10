import Foundation

@MainActor
class RandomPokemonViewModel: ObservableObject {
    @Published var pokemon: Pokemon?
    private let fetchPokemonUseCase: FetchPokemonByIDUseCase

    init(fetchPokemonUseCase: FetchPokemonByIDUseCase = FetchPokemonByIDUseCase(repository: PokemonRepositoryImpl())) {
        self.fetchPokemonUseCase = fetchPokemonUseCase
    }

    func loadRandomPokemon() async {
        let id = Int.random(in: 1...151)
        do {
            pokemon = try await fetchPokemonUseCase.execute(id: id)
        } catch {
            print("Failed to fetch Pokémon: \(error)")
        }
    }
}

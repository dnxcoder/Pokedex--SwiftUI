import Foundation

struct PokemonEntry: Decodable {
    let name: String
    let url: String
}

struct Pokemon: Identifiable, Hashable {
    let id: Int
    let name: String
    let types: [String]
    let height: Int
    let weight: Int
    let baseExperience: Int
    let abilities: [String]

    var imageURL: URL {
        URL(string: "https://raw.githubusercontent.com/PokeAPI/sprites/master/sprites/pokemon/\(id).png")!
    }

    var cryURL: URL {
        URL(string: "https://raw.githubusercontent.com/PokeAPI/cries/main/cries/pokemon/latest/\(id).ogg")!
    }

    var primaryType: String { types.first ?? "" }
}

struct PokemonList: Decodable {
    let results: [PokemonEntry]
}

import Foundation

struct PokemonEntry: Decodable {
    let name: String
    let url: String
}

struct Pokemon: Identifiable {
    let id: Int
    let name: String
    let types: [String]

    var imageURL: URL {
        URL(string: "https://raw.githubusercontent.com/PokeAPI/sprites/master/sprites/pokemon/\(id).png")!
    }

    var primaryType: String { types.first ?? "" }
}

struct PokemonList: Decodable {
    let results: [PokemonEntry]
}

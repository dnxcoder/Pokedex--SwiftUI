import Foundation

struct PokemonEntry: Decodable {
    let name: String
    let url: String
}

struct Pokemon: Identifiable {
    let id: Int
    let name: String
    var imageURL: URL {
        URL(string: "https://raw.githubusercontent.com/PokeAPI/sprites/master/sprites/pokemon/\(id).png")!
    }
}

struct PokemonList: Decodable {
    let results: [PokemonEntry]
}

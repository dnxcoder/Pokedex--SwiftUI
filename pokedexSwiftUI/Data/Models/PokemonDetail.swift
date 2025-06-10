import Foundation

struct PokemonDetail: Decodable {
    struct TypeEntry: Decodable {
        struct Info: Decodable { let name: String }
        let type: Info
    }
    struct AbilityEntry: Decodable {
        struct Info: Decodable { let name: String }
        let ability: Info
    }
    let id: Int
    let name: String
    let types: [TypeEntry]
    let height: Int
    let weight: Int
    let base_experience: Int
    let abilities: [AbilityEntry]
}

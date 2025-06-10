import SwiftUI

struct TypesView: View {
    private let types: [String] = [
        "Normal", "Fire", "Water", "Grass", "Electric", "Ice",
        "Fighting", "Poison", "Ground", "Flying", "Psychic", "Bug",
        "Rock", "Ghost", "Dragon", "Dark", "Steel", "Fairy"
    ]

    var body: some View {
        List(types, id: \.self) { type in
            Text(type)
        }
        .navigationTitle("Types")
    }
}

#Preview {
    NavigationStack {
        TypesView()
    }
}

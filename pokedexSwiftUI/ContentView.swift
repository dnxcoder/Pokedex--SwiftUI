import SwiftUI

struct ContentView: View {
    @StateObject private var viewModel = PokedexViewModel()
    private let columns = [GridItem(.flexible()), GridItem(.flexible())]

    private func color(for type: String) -> Color {
        switch type {
        case "fire": return .red
        case "water": return .blue
        case "grass": return .green
        case "electric": return .yellow
        case "poison": return .purple
        case "bug": return .green.opacity(0.7)
        case "ground": return .brown
        case "psychic": return .pink
        case "rock": return .gray
        case "ghost": return .indigo
        case "ice": return .cyan
        case "dragon": return .orange
        default: return Color(.systemGray6)
        }
    }

    var body: some View {
        NavigationStack {
            ScrollView {
                LazyVGrid(columns: columns, spacing: 16) {
                    ForEach(viewModel.pokemon) { pokemon in
                        VStack {
                            AsyncImage(url: pokemon.imageURL) { image in
                                image.resizable()
                                    .aspectRatio(contentMode: .fit)
                            } placeholder: {
                                ProgressView()
                            }
                            .frame(width: 96, height: 96)
                            Text(pokemon.name)
                                .font(.headline)
                                .fontWeight(.semibold)
                                .lineLimit(1)
                        }
                        .padding(8)
                        .background(RoundedRectangle(cornerRadius: 8).fill(color(for: pokemon.primaryType)))
                    }
                }
                .padding()
            }
            .navigationTitle("Pokédex")
        }
        .task {
            await viewModel.fetchPokemon()
        }
    }
}

#Preview {
    ContentView()
}

import SwiftUI

struct HomeView: View {
    @StateObject private var viewModel = PokedexViewModel()

    private func color(for type: String) -> Color {
        switch type {
        case "fire": return .red.opacity(0.3)
        case "water": return .blue.opacity(0.3)
        case "grass": return .green.opacity(0.3)
        case "electric": return .yellow.opacity(0.3)
        case "poison": return .purple.opacity(0.3)
        case "bug": return .green.opacity(0.3)
        case "ground": return .brown.opacity(0.3)
        case "psychic": return .pink.opacity(0.3)
        case "rock": return .gray.opacity(0.3)
        case "ghost": return .indigo.opacity(0.3)
        case "ice": return .cyan.opacity(0.3)
        case "dragon": return .orange.opacity(0.3)
        default: return Color(.systemGray6)
        }
    }

    var body: some View {
        List(viewModel.pokemon) { pokemon in
            NavigationLink(value: pokemon) {
                HStack {
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
                }
                .padding(8)
                .background(RoundedRectangle(cornerRadius: 8).fill(color(for: pokemon.primaryType)))
            }
        }
        .listStyle(.plain)
        .navigationTitle("Pokédex")
        .task {
            await viewModel.fetchPokemon()
        }
    }
}

#Preview {
    NavigationStack {
        HomeView()
    }
}

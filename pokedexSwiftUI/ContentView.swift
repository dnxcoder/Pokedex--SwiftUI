import SwiftUI

struct ContentView: View {
    @StateObject private var viewModel = PokedexViewModel()
    private let columns = [GridItem(.adaptive(minimum: 80))]

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
                            .frame(width: 72, height: 72)
                            Text(pokemon.name)
                                .font(.caption)
                                .lineLimit(1)
                        }
                        .padding(4)
                        .background(RoundedRectangle(cornerRadius: 8).fill(Color(.systemGray6)))
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

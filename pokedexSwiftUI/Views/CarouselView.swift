import SwiftUI

struct CarouselView: View {
    @StateObject private var viewModel = PokedexViewModel()
    @State private var selection: Int = 0

    var body: some View {
        TabView(selection: $selection) {
            ForEach(viewModel.pokemon) { pokemon in
                CarouselCardView(pokemon: pokemon)
                    .tag(pokemon.id)
            }
        }
        .tabViewStyle(PageTabViewStyle(indexDisplayMode: .automatic))
        .onAppear {
            Task { await viewModel.fetchPokemon() }
        }
        .navigationTitle("Carousel")
    }
}

struct CarouselCardView: View {
    let pokemon: Pokemon
    @State private var appear = false

    var body: some View {
        NavigationLink(value: pokemon) {
            VStack(spacing: 16) {
                AsyncImage(url: pokemon.imageURL) { image in
                    image.resizable()
                        .aspectRatio(contentMode: .fit)
                } placeholder: {
                    ProgressView()
                }
                .frame(maxWidth: .infinity)
                .frame(height: 300)
                .offset(y: appear ? 0 : 200)
                .animation(.spring(), value: appear)

                Text(pokemon.name)
                    .font(.largeTitle)
                    .bold()
            }
            .frame(maxWidth: .infinity, maxHeight: .infinity)
            .padding()
        }
        .buttonStyle(.plain)
        .onAppear { appear = true }
        .onDisappear { appear = false }
    }
}

#Preview {
    NavigationStack {
        CarouselView()
    }
}

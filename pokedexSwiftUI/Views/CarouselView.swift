import SwiftUI

/// Horizontal carousel built with a ScrollView. Each card slides up as it
/// approaches the center and the background color shifts smoothly based on the
/// scroll position.
struct CarouselView: View {
    @StateObject private var viewModel = PokedexViewModel()
    @State private var scrollOffset: CGFloat = 0

    private let cardWidth: CGFloat = 250
    private let cardSpacing: CGFloat = 16

    var body: some View {
        GeometryReader { outer in
            ZStack {
                backgroundColor
                    .ignoresSafeArea()

                ScrollView(.horizontal, showsIndicators: false) {
                    HStack(spacing: cardSpacing) {
                        ForEach(viewModel.pokemon) { pokemon in
                            GeometryReader { geo in
                                let frame = geo.frame(in: .global)
                                let distance = abs(frame.midX - outer.frame(in: .global).midX)
                                let progress = min(distance / outer.size.width, 1)
                                let offsetY = progress * 200
                                let scale = 1 - progress * 0.2

                                NavigationLink(value: pokemon) {
                                    CarouselCardView(pokemon: pokemon)
                                        .offset(y: offsetY)
                                        .scaleEffect(scale)
                                        .opacity(1 - progress * 0.5)
                                }
                                .buttonStyle(.plain)
                            }
                            .frame(width: cardWidth, height: 350)
                        }
                    }
                    .padding(.horizontal, (outer.size.width - cardWidth) / 2)
                    .background(
                        GeometryReader { geo in
                            Color.clear.preference(key: ScrollOffsetKey.self, value: -geo.frame(in: .named("scroll")).origin.x)
                        }
                    )
                }
                .coordinateSpace(name: "scroll")
                .onPreferenceChange(ScrollOffsetKey.self) { value in
                    scrollOffset = value
                }
                .onAppear { Task { await viewModel.fetchPokemon() } }
            }
            .navigationTitle("Carousel")
        }
    }

    /// Background color interpolated from the current scroll position.
    private var backgroundColor: Color {
        guard !viewModel.pokemon.isEmpty else { return Color(.systemBackground) }
        let total = cardWidth * CGFloat(viewModel.pokemon.count)
        let hue = Double((scrollOffset / total).truncatingRemainder(dividingBy: 1))
        return Color(hue: hue, saturation: 0.4, brightness: 1)
    }
}

private struct CarouselCardView: View {
    let pokemon: Pokemon

    var body: some View {
        VStack(spacing: 16) {
            AsyncImage(url: pokemon.imageURL) { image in
                image.resizable().aspectRatio(contentMode: .fit)
            } placeholder: {
                ProgressView()
            }
            .frame(height: 200)
            Text(pokemon.name)
                .font(.title)
                .bold()
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity)
        .padding()
        .background(
            RoundedRectangle(cornerRadius: 12)
                .fill(Color(.systemBackground).opacity(0.8))
        )
    }
}

/// Preference key used to pass the horizontal scroll offset up the view hierarchy.
private struct ScrollOffsetKey: PreferenceKey {
    static var defaultValue: CGFloat = 0
    static func reduce(value: inout CGFloat, nextValue: () -> CGFloat) {
        value = nextValue()
    }
}

#Preview {
    NavigationStack {
        CarouselView()
    }
}

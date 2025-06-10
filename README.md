# Pokedex--SwiftUI

This simple SwiftUI app displays the first 151 Pokémon using data from [PokeAPI](https://pokeapi.co/). The list is shown in a modern adaptive grid and each entry loads its sprite asynchronously.

The project now follows a lightweight Clean Architecture structure with separate layers for Domain, Data and Presentation. Use cases and repositories handle all data loading outside of the UI code.

Run the project in Xcode to see the Pokédex in action.

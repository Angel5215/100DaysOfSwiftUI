//
// ContentView.swift
// Last modified by 'Ángel Vázquez' in 2024.
//

import SwiftUI

struct ContentView: View {
    let astronauts: [String: Astronaut] = Bundle.main.decode("astronauts.json")
    let missions: [Mission] = Bundle.main.decode("missions.json")

    @State private var showingGrid = false

    var body: some View {
        NavigationStack {
            Group {
                if showingGrid {
                    GridLayout(astronauts: astronauts, missions: missions)
                } else {
                    ListLayout(astronauts: astronauts, missions: missions)
                }
            }
            .navigationTitle("Moonshot")
            .background(.darkBackground)
            .preferredColorScheme(.dark)
            .toolbar {
                Button("Toggle view", systemImage: showingGrid ? "square.fill.text.grid.1x2" : "square.grid.3x2.fill") {
                    withAnimation(.default) {
                        showingGrid.toggle()
                    }
                }
            }
        }
    }
}

#Preview {
    ContentView()
}

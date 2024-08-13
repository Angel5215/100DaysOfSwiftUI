//
// ContentView.swift
// Last modified by 'Ángel Vázquez' in 2024.
//

import SwiftUI

struct ContentView: View {
    let astronauts: [String: Astronaut] = Bundle.main.decode("astronauts.json")
    let missions: [Mission] = Bundle.main.decode("missions.json")

    @State private var showingGrid = false
    @State private var pathStore = PathStore()

    var body: some View {
        NavigationStack(path: $pathStore.path) {
            Group {
                if showingGrid {
                    GridLayout(missions: missions)
                } else {
                    ListLayout(missions: missions)
                }
            }
            .navigationTitle("Moonshot")
            .background(.darkBackground)
            .preferredColorScheme(.dark)
            .navigationDestination(for: Mission.self) { mission in
                MissionView(mission: mission, astronauts: astronauts)
            }
            .navigationDestination(for: CrewMember.self) { crewMember in
                AstronautView(astronaut: crewMember.astronaut)
            }
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

//
// ContentView.swift
// Last modified by 'Ángel Vázquez' in 2024.
//

import SwiftUI

struct ContentView: View {
    let astronauts = Bundle.main.decode("astronauts.json")

    var body: some View {
        VStack {
            Text(String(astronauts.count))
        }
        .padding()
    }
}

#Preview {
    ContentView()
}

//
// ContentView.swift
// Last modified by 'Ángel Vázquez' in 2024.
//

import SwiftUI

struct ContentView: View {
    let motto1 = Text("Draco dormiens")
    let motto2 = Text("nunquam titillandus")

    var body: some View {
        VStack(spacing: 10) {
            CapsuleText(text: "First")
                .foregroundStyle(.white)

            CapsuleText(text: "Second")
                .foregroundStyle(.yellow)

            Text("Hello world!")
                .titleStyle()

            Color.blue
                .frame(width: 300, height: 200)
                .watermarked(with: "Hacking with Swift")

            GridStack(rows: 4, columns: 4) { row, col in
                Image(systemName: "\(row * 4 + col).circle")

                Text("R\(row)C\(col)")
                    .font(.body.monospaced())
            }
            .padding()
            .padding()
            .background(.thinMaterial)

            Text("Some title")
                .largeViewTitleStyle()
        }
    }
}

#Preview {
    ContentView()
}

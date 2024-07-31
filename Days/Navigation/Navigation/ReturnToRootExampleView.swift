//
// ReturnToRootExampleView.swift
// Last modified by 'Ángel Vázquez' in 2024.
//

import SwiftUI

struct ReturnToRootExampleView: View {
    @State private var path = [Int]()

    var body: some View {
        NavigationStack(path: $path) {
            DetailView(number: 0, path: $path)
                .navigationDestination(for: Int.self) { i in
                    DetailView(number: i, path: $path)
                }
        }
    }
}

struct DetailView: View {
    var number: Int
    @Binding var path: [Int]

    var body: some View {
        NavigationLink("Go to Random Number", value: Int.random(in: 1 ... 1000))
            .navigationTitle("Number \(number)")
            .toolbar {
                Button("Home") {
                    path.removeAll()
                }
            }
    }
}

#Preview {
    ReturnToRootExampleView()
}

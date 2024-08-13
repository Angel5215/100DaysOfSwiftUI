//
// ReturnToRootExampleObservableView.swift
// Last modified by 'Ángel Vázquez' in 2024.
//

import Observation
import SwiftUI

@Observable
class Destination {
    var path = [Int]()
}

struct ReturnToRootExampleObservableView: View {
    @State private var destination = Destination()

    var body: some View {
        NavigationStack(path: $destination.path) {
            DetailObservableView(number: 0, destination: destination)
                .navigationDestination(for: Int.self) { i in
                    DetailObservableView(number: i, destination: destination)
                }
        }
    }
}

struct DetailObservableView: View {
    var number: Int
    let destination: Destination

    var body: some View {
        NavigationLink("Go to Random Number", value: Int.random(in: 1 ... 1000))
            .navigationTitle("Number \(number)")
            .toolbar {
                Button("Home") {
                    destination.path.removeAll()
                }
            }
    }
}

#Preview {
    ReturnToRootExampleObservableView()
}

//
// CodableNavigationStackView.swift
// Last modified by 'Ángel Vázquez' in 2024.
//

import Observation
import SwiftUI

@Observable
class PathStore {
    var path: [Int] {
        didSet {
            save()
        }
    }

    private let savePath = URL.documentsDirectory.appending(path: "SavedPath")

    init() {
        if let data = try? Data(contentsOf: savePath) {
            if let decoded = try? JSONDecoder().decode([Int].self, from: data) {
                self.path = decoded
                return
            }
        }

        self.path = []
    }

    func save() {
        do {
            let data = try JSONEncoder().encode(path)
            try data.write(to: savePath)
        } catch {
            print("Failed to save navigation data")
        }
    }
}

struct CodableNavigationStackView: View {
    @State private var pathStore = PathStore()

    var body: some View {
        NavigationStack(path: $pathStore.path) {
            CodableDetailView(number: 0)
                .navigationDestination(for: Int.self) { i in
                    CodableDetailView(number: i)
                }
        }
    }
}

struct CodableDetailView: View {
    var number: Int

    var body: some View {
        NavigationLink("Go to Random Number", value: Int.random(in: 1 ... 1000))
            .navigationTitle("Number: \(number)")
    }
}

#Preview {
    CodableNavigationStackView()
}

//
// NavigationBarCustomizationView.swift
// Last modified by 'Ángel Vázquez' in 2024.
//

import SwiftUI

struct NavigationBarCustomizationView: View {
    @State private var title = "SwiftUI"

    var body: some View {
        NavigationStack {
            List(0 ..< 100) { i in
                Text("Row \(i)")
            }
            .navigationTitle($title)
            .navigationBarTitleDisplayMode(.inline)
            .toolbarBackground(.blue)
            .toolbarColorScheme(.dark)
            // .toolbar(.hidden, for: .navigationBar)
            .toolbar {
                ToolbarItemGroup(placement: .topBarLeading) {
                    Button("Tap Me") {}

                    Button("Or Tap Me") {}
                }
            }
        }
    }
}

#Preview {
    NavigationBarCustomizationView()
}

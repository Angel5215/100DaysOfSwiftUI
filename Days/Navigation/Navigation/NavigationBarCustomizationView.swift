//
// NavigationBarCustomizationView.swift
// Last modified by 'Ángel Vázquez' in 2024.
//

import SwiftUI

struct NavigationBarCustomizationView: View {
    var body: some View {
        NavigationStack {
            List(0 ..< 100) { i in
                Text("Row \(i)")
            }
            .navigationTitle("Title goes here")
            .navigationBarTitleDisplayMode(.inline)
            .toolbarBackground(.blue)
            .toolbarColorScheme(.dark)
            .toolbar(.hidden, for: .navigationBar)
        }
    }
}

#Preview {
    NavigationBarCustomizationView()
}

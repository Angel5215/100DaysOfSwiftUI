//
// ContentView.swift
// Last modified by 'Ángel Vázquez' in 2024.
//

import SwiftUI

struct ContentView: View {
    @State private var path = NavigationPath()

    var body: some View {
        NavigationStack(path: $path) {
            List {
                ForEach(0 ..< 5) { i in
                    NavigationLink("Select Number: \(i)", value: i)
                }

                ForEach(0 ..< 5) { i in
                    NavigationLink("Select String: \(i)", value: String(i))
                }
            }
            .navigationDestination(for: Int.self) { selection in
                Text("You selected the number \(selection)")
            }
            .navigationDestination(for: String.self) { selection in
                Text("You selected the string \(selection)")
            }
            .toolbar {
                Button("Push 556") {
                    path.append(556)
                }

                Button("Push Hello") {
                    path.append("Hello")
                }
            }
        }
    }
}

#Preview {
    ContentView()
}

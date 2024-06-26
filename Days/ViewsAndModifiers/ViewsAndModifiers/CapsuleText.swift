//
// CapsuleText.swift
// Last modified by 'Ángel Vázquez' in 2024.
//

import SwiftUI

struct CapsuleText: View {
    var text: String

    var body: some View {
        Text(text)
            .font(.largeTitle)
            .padding()
            .background(.blue)
            .clipShape(.capsule)
    }
}

#Preview {
    CapsuleText(text: "Hello world!")
}

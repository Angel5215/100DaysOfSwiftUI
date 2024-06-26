//
// LargeBlueTitle.swift
// Last modified by 'Ángel Vázquez' in 2024.
//

import SwiftUI

struct LargeBlueTitle: ViewModifier {
    func body(content: Content) -> some View {
        content
            .font(.largeTitle)
            .foregroundStyle(.blue)
    }
}

extension View {
    func largeViewTitleStyle() -> some View {
        modifier(LargeBlueTitle())
    }
}

#Preview {
    Text("Hello world!")
        .largeViewTitleStyle()
}

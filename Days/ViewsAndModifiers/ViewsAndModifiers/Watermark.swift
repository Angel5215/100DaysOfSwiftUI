//
// Watermark.swift
// Last modified by 'Ángel Vázquez' in 2024.
//

import SwiftUI

struct Watermark: ViewModifier {
    var text: String

    func body(content: Content) -> some View {
        ZStack(alignment: .bottomTrailing) {
            content

            Text(text)
                .font(.caption)
                .foregroundStyle(.white)
                .padding(5)
                .background(.black)
        }
    }
}

extension View {
    func watermarked(with text: String) -> some View {
        modifier(Watermark(text: text))
    }
}

#Preview {
    ZStack {
        Color.red
            .frame(width: 200, height: 300)
            .watermarked(with: "Hello")
    }
}

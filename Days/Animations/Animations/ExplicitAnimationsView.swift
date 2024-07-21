//
// ExplicitAnimationsView.swift
// Last modified by 'Ángel Vázquez' in 2024.
//

import SwiftUI

struct ExplicitAnimationsView: View {
    @State private var animationAmount = 0.0

    var body: some View {
        Button("Tap me") {
            withAnimation {
                animationAmount += 360
            }
        }
        .padding(50)
        .background(.red)
        .foregroundStyle(.white)
        .clipShape(.circle)
        .rotation3DEffect(
            .degrees(animationAmount),
            axis: (x: 0, y: 1, z: 0)
        )
    }
}

#Preview {
    ExplicitAnimationsView()
}

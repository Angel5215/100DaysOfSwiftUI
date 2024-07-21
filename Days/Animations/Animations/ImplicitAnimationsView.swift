//
// ImplicitAnimationsView.swift
// Last modified by 'Ángel Vázquez' in 2024.
//

import SwiftUI

struct ImplicitAnimationsView: View {
    @State private var animationAmount = 1.0

    var body: some View {
        Button("Tap me") {
            animationAmount += 1
        }
        .padding(50)
        .background(.red)
        .foregroundColor(.white)
        .clipShape(.circle)
        .scaleEffect(animationAmount)
        .blur(radius: (animationAmount - 1) * 3)
        .animation(.default, value: animationAmount)
    }
}

#Preview {
    ImplicitAnimationsView()
}

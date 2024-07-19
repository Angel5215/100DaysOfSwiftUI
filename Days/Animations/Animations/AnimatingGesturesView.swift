//
// AnimatingGesturesView.swift
// Last modified by 'Ángel Vázquez' in 2024.
//

import SwiftUI

struct AnimatingGesturesView: View {
    @State private var dragAmount = CGSize.zero

    var body: some View {
        LinearGradient(colors: [.yellow, .red], startPoint: .topLeading, endPoint: .bottomTrailing)
            .frame(width: 300, height: 200)
            .clipShape(.rect(cornerRadius: 10))
            .offset(dragAmount)
            .gesture(
                DragGesture()
                    .onChanged { dragAmount = $0.translation }
                    .onEnded { _ in
                        withAnimation(.bouncy) {
                            dragAmount = .zero
                        }
                    }
            )
    }
}

#Preview {
    AnimatingGesturesView()
}

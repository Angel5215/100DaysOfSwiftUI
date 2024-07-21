//
// TransitionsView.swift
// Last modified by 'Ángel Vázquez' in 2024.
//

import SwiftUI

struct TransitionsView: View {
    @State private var isShowingRed = false

    var body: some View {
        VStack {
            Button("Tap me") {
                withAnimation {
                    isShowingRed.toggle()
                }
            }

            if isShowingRed {
                Rectangle()
                    .fill(.red)
                    .frame(width: 200, height: 200)
                    .transition(
                        .asymmetric(
                            insertion: .scale,
                            removal: .opacity
                        )
                    )
            }
        }
    }
}

#Preview {
    TransitionsView()
}

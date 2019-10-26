//
//  GestureAnimation.swift
//  Animations
//
//  Created by Angel Vázquez on 26/10/19.
//  Copyright © 2019 Ángel Vázquez. All rights reserved.
//

import SwiftUI

struct GestureAnimation: View {
    
    let letters = Array("Hello SwiftUI")
    @State private var enabled = false
    @State private var letterDragAmount = CGSize.zero
    @State private var dragAmount = CGSize.zero
    
    var body: some View {
        
        ZStack {
            LinearGradient(gradient: Gradient(colors: [.yellow, .red]),
                           startPoint: .topLeading,
                           endPoint: .bottomTrailing)
                .frame(width: 300, height: 200)
                .clipShape(RoundedRectangle(cornerRadius: 10))
                .offset(dragAmount)
                .gesture(
                    DragGesture()
                        .onChanged { self.dragAmount = $0.translation }
                        .onEnded { _ in
                            withAnimation(.spring()) {
                                self.dragAmount = .zero
                            }
                        }
                )
            
            HStack(spacing: 0) {
                ForEach(0 ..< letters.count) { num in
                    Text(String(self.letters[num]))
                        .padding(5)
                        .font(.title)
                        .background(self.enabled ? Color.blue : Color.red)
                        .offset(self.letterDragAmount)
                        .animation(Animation.default.delay(Double(num) / 20))
                }
            }
            .gesture(
                DragGesture()
                    .onChanged { self.letterDragAmount = $0.translation }
                    .onEnded { _ in
                        self.letterDragAmount = .zero
                        self.enabled.toggle()
                    }
            )
        }
    }
}

struct GestureAnimation_Previews: PreviewProvider {
    static var previews: some View {
        GestureAnimation()
    }
}

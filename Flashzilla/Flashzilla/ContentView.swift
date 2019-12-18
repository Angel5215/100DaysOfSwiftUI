//
//  ContentView.swift
//  Flashzilla
//
//  Created by Angel Vázquez on 17/12/19.
//  Copyright © 2019 Ángel Vázquez. All rights reserved.
//

import SwiftUI

struct ContentView: View {
    
    @State private var magnificationCurrentAmount: CGFloat = 0
    @State private var magnificationFinalAmount: CGFloat = 1
    
    @State private var rotationCurrentAmount: Angle = .degrees(0)
    @State private var rotationFinalAmount: Angle = .degrees(0)
    
    var body: some View {
        VStack(spacing: 40) {
            Text("Double tap")
                .onTapGesture(count: 2) {
                    print("Double tapped!")
                }
            
            Text("Long press")
            .onLongPressGesture(minimumDuration: 1, pressing: { inProgress in
                print("In progress: \(inProgress)!")
            }, perform: {
                print("Long pressed!")
            })
            
            Text("Magnification gesture")
                .scaleEffect(magnificationFinalAmount - magnificationCurrentAmount)
                .gesture(
                    MagnificationGesture()
                        .onChanged { amount in
                            self.magnificationCurrentAmount = amount - 1
                        }
                        .onEnded { amount in
                            self.magnificationFinalAmount += self.magnificationCurrentAmount
                            self.magnificationCurrentAmount = 0
                        }
                )
            
            Text("Rotating gesture")
                .rotationEffect(rotationCurrentAmount + rotationFinalAmount)
                .gesture(
                    RotationGesture()
                        .onChanged { angle in
                            self.rotationCurrentAmount = angle
                    }
                    .onEnded { angle in
                        self.rotationFinalAmount += self.rotationCurrentAmount
                        self.rotationCurrentAmount = .degrees(0)
                    }
            )
            
            // When two gestures clash, the gesture of the child takes priority
            VStack {
                Text("Gesture clash")
                    .onTapGesture {
                        print("Text tapped")
                    }
            }
            .onTapGesture {
                print("VStack tapped")
            }
            
            VStack {
                Text("High priority gesture")
                    .onTapGesture {
                        print("Text tapped")
                    }
            }
            .highPriorityGesture(
                TapGesture()
                    .onEnded { _ in
                        print("VStack tapped")
                    }
            )
            
            VStack {
                Text("Simultaneous gesture")
                    .onTapGesture {
                        print("Text tapped")
                    }
            }
            .simultaneousGesture(
                TapGesture()
                    .onEnded { _ in
                        print("VStack tapped")
                    }
            )
            
            DraggableCircle()
        }
    }
}

struct DraggableCircle: View {
    // how far the circle has been dragged
    @State private var offset = CGSize.zero

    // where it is currently being dragged or not
    @State private var isDragging = false

    var body: some View {
        // a drag gesture that updates offset and isDragging as it moves around
        let dragGesture = DragGesture()
            .onChanged { value in self.offset = value.translation }
            .onEnded { _ in
                withAnimation {
                    self.offset = .zero
                    self.isDragging = false
                }
            }

        // a long press gesture that enables isDragging
        let tapGesture = LongPressGesture()
            .onEnded { value in
                withAnimation {
                    self.isDragging = true
                }
            }

        // a combined gesture that forces the user to long press then drag
        let combined = tapGesture.sequenced(before: dragGesture)

        // a 64x64 circle that scales up when it's dragged, sets its offset to whatever we had back from the drag gesture, and uses our combined gesture
        return Circle()
            .fill(Color.red)
            .frame(width: 64, height: 64)
            .scaleEffect(isDragging ? 1.5 : 1)
            .offset(offset)
            .gesture(combined)
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}

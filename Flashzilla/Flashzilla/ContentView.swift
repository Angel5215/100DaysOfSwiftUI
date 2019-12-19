//
//  ContentView.swift
//  Flashzilla
//
//  Created by Angel Vázquez on 17/12/19.
//  Copyright © 2019 Ángel Vázquez. All rights reserved.
//

import SwiftUI
import CoreHaptics

struct ContentView: View {
    
    // Timer fires every second; it should run on the main thread;
    // it should run on the common run loop. It connects the timer immediately
    // which means it will start counting time.
    let timer = Timer.publish(every: 1, tolerance: 0.5, on: .main, in: .common).autoconnect()
    @State private var counter = 0
    
    var body: some View {
        Text("Hello world!")
            .onReceive(timer) { time in
                if self.counter == 5 {
                    self.timer.upstream.connect().cancel()
                } else {
                    print("The time is now \(time)")
                }
                
                self.counter += 1
            }
            .onReceive(NotificationCenter.default.publisher(for: UIApplication.willResignActiveNotification)) { _ in
                print("Moving to the background!")
            }
            .onReceive(NotificationCenter.default.publisher(for: UIApplication.willEnterForegroundNotification)) { _ in
                print("Moving back to the foreground!")
            }
            .onReceive(NotificationCenter.default.publisher(for: UIApplication.userDidTakeScreenshotNotification)) { _ in
                print("User took a screenshot!")
            }
    }
}

struct UserInteractivityView: View {
    var body: some View {
        ZStack {
            Rectangle()
                .fill(Color.blue)
                .frame(width: 300, height: 300)
                .onTapGesture {
                    print("Rectangle tapped!")
                }

            Circle()
                .fill(Color.red)
                .frame(width: 300, height: 300)
                .contentShape(Rectangle())
                .onTapGesture {
                    print("Circle tapped!")
                }
                //.allowsHitTesting(false)
        }
    }
}

struct HapticsView: View {
    
    @State private var engine: CHHapticEngine?
    
    var body: some View {
        VStack(spacing: 40) {
            Text("Simple Success")
            .onTapGesture(perform: simpleSuccess)

            Text("Simple Warning")
            .onTapGesture(perform: simpleWarning)

            Text("Simple Error")
            .onTapGesture(perform: simpleError)
            
            Text("Complex success")
                .onTapGesture(perform: complexSuccess)
            
            Text("Increasing taps")
                .onTapGesture(perform: increasingTaps)
            
            Text("Decreasing taps")
                .onTapGesture(perform: decreasingTaps)
        }
        .onAppear(perform: prepareHaptics)
    }
    
    
    func simpleSuccess() {
        let generator = UINotificationFeedbackGenerator()
        generator.notificationOccurred(.success)
    }
    
    func simpleError() {
        let generator = UINotificationFeedbackGenerator()
        generator.notificationOccurred(.error)
    }
    
    func simpleWarning() {
        let generator = UINotificationFeedbackGenerator()
        generator.notificationOccurred(.warning)
    }
    
    func complexSuccess() {
        // make sure that the device supports haptics
        guard CHHapticEngine.capabilitiesForHardware().supportsHaptics else { return }
        var events = [CHHapticEvent]()
        
        // create one intense, sharp tap
        let intensity = CHHapticEventParameter(parameterID: .hapticIntensity, value: 1)
        let sharpness = CHHapticEventParameter(parameterID: .hapticSharpness, value: 1)
        let event = CHHapticEvent(eventType: .hapticTransient, parameters: [intensity, sharpness], relativeTime: 0)
        events.append(event)
        
        // convert those events into a pattern and play it immediately
        do {
            let pattern = try CHHapticPattern(events: events, parameterCurves: [])
            let player = try engine?.makePlayer(with: pattern)
            try player?.start(atTime: 0)
        } catch {
            
        }
    }
    
    func increasingTaps() {
           // make sure that the device supports haptics
           guard CHHapticEngine.capabilitiesForHardware().supportsHaptics else { return }
           var events = [CHHapticEvent]()
           
           // create one intense, sharp tap
           for i in stride(from: 0, to: 1, by: 0.1) {
               let intensity = CHHapticEventParameter(parameterID: .hapticIntensity, value: Float(i))
               let sharpness = CHHapticEventParameter(parameterID: .hapticSharpness, value: Float(i))
               let event = CHHapticEvent(eventType: .hapticTransient, parameters: [intensity, sharpness], relativeTime: i)
               events.append(event)
           }
           
           // convert those events into a pattern and play it immediately
           do {
               let pattern = try CHHapticPattern(events: events, parameterCurves: [])
               let player = try engine?.makePlayer(with: pattern)
               try player?.start(atTime: 0)
           } catch {
               
           }
       }
    
    func decreasingTaps() {
           // make sure that the device supports haptics
           guard CHHapticEngine.capabilitiesForHardware().supportsHaptics else { return }
           var events = [CHHapticEvent]()
           
           // create one intense, sharp tap
           for i in stride(from: 0, to: 1, by: 0.1) {
               let intensity = CHHapticEventParameter(parameterID: .hapticIntensity, value: Float(1 - i))
               let sharpness = CHHapticEventParameter(parameterID: .hapticSharpness, value: Float(1 - i))
               let event = CHHapticEvent(eventType: .hapticTransient, parameters: [intensity, sharpness], relativeTime: 1 + i)
               events.append(event)
           }
           
           // convert those events into a pattern and play it immediately
           do {
               let pattern = try CHHapticPattern(events: events, parameterCurves: [])
               let player = try engine?.makePlayer(with: pattern)
               try player?.start(atTime: 0)
           } catch {
               
           }
       }
    
    func prepareHaptics() {
        guard CHHapticEngine.capabilitiesForHardware().supportsHaptics else { return }
        
        do {
            self.engine = try CHHapticEngine()
            try engine?.start()
        } catch {
            print("There was an error creating the engine: \(error.localizedDescription)")
        }
    }
}

struct GesturesView: View {
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

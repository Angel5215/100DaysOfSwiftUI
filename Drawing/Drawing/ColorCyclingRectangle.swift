//
//  RectangleCyclingView.swift
//  Drawing
//
//  Created by Angel Vázquez on 07/11/19.
//  Copyright © 2019 Ángel Vázquez. All rights reserved.
//

import SwiftUI

struct ColorCyclingRectangleView: View {
    
    @State private var colorCycle = 0.0
    @State private var startPoint = 5
    @State private var endPoint = 0
    @State private var maxBrightness = 1.0
    @State private var minBrightness = 0.5
    
    private let selections: [UnitPoint] = [
        .bottom, .bottomLeading, .bottomTrailing, .center,
        .leading, .top, .topLeading, .topTrailing, .trailing
    ]
    
    private let labels: [String] = [
        "B", "BL", "BT", "C",
        "L", "To", "ToL", "ToT", "Tr"
    ]
    
    private let fullLabels: [String] = [
        "Bottom", "Bottom Leading", "Bottom Trailing", "Center",
        "Leading", "Top", "Top Leading", "Top Trailing", "Trailing"
    ]
    
    var body: some View {
        VStack {
            ColorCyclingRectangle(amount: self.colorCycle,
                                  startPoint: self.selections[startPoint],
                                  endPoint: self.selections[endPoint],
                                  maxBrightness: maxBrightness,
                                  minBrightness: minBrightness)
                .padding()
                .frame(width: 300, height: 250)
            
            Spacer()
            
            ScrollView(.vertical) {
                VStack(spacing: 0) {
                    Text("Cycle amount: \(colorCycle, specifier: "%.2f")").font(.headline)
                    Slider(value: $colorCycle).padding(.horizontal)
                }
                
                VStack(spacing: 0) {
                    Text("Max brightness \(maxBrightness, specifier: "%.2f")").font(.headline)
                    Slider(value: $maxBrightness).padding(.horizontal)
                }
                
                VStack(spacing: 0) {
                    Text("Min brightness \(minBrightness, specifier: "%.2f")").font(.headline)
                    Slider(value: $minBrightness).padding(.horizontal)
                }
                
                VStack {
                    Text("Start point: \(fullLabels[startPoint])").font(.headline)
                    Picker("Start point", selection: $startPoint) {
                        ForEach(0..<labels.count) { number in
                            Text(self.labels[number])
                        }
                    }
                    .labelsHidden()
                    .padding(.horizontal)
                    .pickerStyle(SegmentedPickerStyle())
                }
                
                VStack {
                    Text("End point: \(fullLabels[endPoint])").font(.headline)
                    Picker("End point", selection: $endPoint) {
                        ForEach(0..<labels.count) { number in
                            Text(self.labels[number])
                        }
                    }
                    .labelsHidden()
                    .padding(.horizontal)
                    .pickerStyle(SegmentedPickerStyle())
                }
            }
        }
        .navigationBarTitle("Challenge 3 - Rectangle", displayMode: .inline)
    }
}

struct ColorCyclingRectangle: View {
    var amount = 0.0
    var steps = 100
    var startPoint: UnitPoint
    var endPoint: UnitPoint
    var maxBrightness = 1.0
    var minBrightness = 0.5
    
    var body: some View {
        ZStack {
            ForEach(0..<steps) { value in
                RoundedRectangle(cornerRadius: 5)
                    .inset(by: CGFloat(value))
                    .strokeBorder(LinearGradient(gradient: Gradient(colors: [self.color(for: value, brightness: self.maxBrightness), self.color(for: value, brightness: self.minBrightness)]), startPoint: self.startPoint, endPoint: self.endPoint))
            }
        }
        .drawingGroup()
    }
    
    func color(for value: Int, brightness: Double) -> Color {
        var targetHue = Double(value) / Double(self.steps) + self.amount
        
        if targetHue > 1 {
            targetHue -= 1
        }
        
        return Color(hue: targetHue, saturation: 1, brightness: brightness)
    }
}

struct ColorCyclingRectangleView_Previews: PreviewProvider {
    static var previews: some View {
        ColorCyclingRectangleView()
    }
}

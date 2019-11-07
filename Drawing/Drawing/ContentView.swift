//
//  ContentView.swift
//  Drawing
//
//  Created by Angel Vázquez on 04/11/19.
//  Copyright © 2019 Ángel Vázquez. All rights reserved.
//

import SwiftUI

struct ContentView: View {
    var body: some View {
        NavigationView {
            List {
                NavigationLink(destination: TriangleView()) {
                    Image(systemName: "1.circle")
                    Text("Triangle")
                }
                
                NavigationLink(destination: ArcView()) {
                    Image(systemName: "2.circle")
                    Text("Arc")
                }
                
                NavigationLink(destination: PetalView()) {
                    Image(systemName: "3.circle")
                    Text("Flower")
                }
                
                NavigationLink(destination: ImagePaintView()) {
                    Image(systemName: "4.circle")
                    Text("ImagePaint border")
                }
                
                NavigationLink(destination: ColorCyclingView()) {
                    Image(systemName: "5.circle")
                    Text("Color cycling circle with Metal")
                }
            }
            .navigationBarTitle("Drawing")
        }
    }
}

struct ColorCyclingView: View {
    @State private var colorCycle = 0.0

    var body: some View {
        VStack {
            ColorCyclingCircle(amount: self.colorCycle)
                .frame(width: 300, height: 300)
            Slider(value: $colorCycle)
        }
        .navigationBarTitle("Color Cycling Circle", displayMode: .inline)
    }
}

struct ImagePaintView: View {
    var body: some View {
        Capsule()
            .strokeBorder(ImagePaint(image: Image("images"), scale: 0.1), lineWidth: 20)
            .frame(width: 300, height: 200)
            .navigationBarTitle("ImagePaint border", displayMode: .inline)
    }
}

struct TriangleView: View {
    var body: some View {
        Triangle()
            .fill(Color.red)
            .frame(width: 300, height: 300)
            .navigationBarTitle("Triangle", displayMode: .inline)
    }
}

struct ArcView: View {
    var body: some View {
        Arc(startAngle: .degrees(0), endAngle: .degrees(110), clockwise: true)
            .strokeBorder(Color.blue, lineWidth: 40)
            .frame(width: 300, height: 300)
            .navigationBarTitle("Arc", displayMode: .inline)
    }
}

struct PetalView: View {
    
    @State private var petalOffset = -20.0
    @State private var petalWidth = 100.0
    
    var body: some View {
        VStack {
            Flower(petalOffset: petalOffset, petalWidth: petalWidth)
                .fill(Color.red, style: FillStyle(eoFill: true))
            
            Text("Offset")
            Slider(value: $petalOffset, in: -40...40).padding([.horizontal, .bottom])
            
            Text("Width")
            Slider(value: $petalWidth, in: 0...100).padding([.horizontal, .bottom])
        }
        .navigationBarTitle("Flower", displayMode: .inline)
    }
}

struct ColorCyclingCircle: View {
    var amount = 0.0
    var steps = 100
    
    var body: some View {
        ZStack {
            ForEach(0 ..< steps) { value in
                Circle()
                    .inset(by: CGFloat(value))
                    .strokeBorder(LinearGradient(gradient: Gradient(colors: [
                        self.color(for: value, brightness: 1),
                        self.color(for: value, brightness: 0.5)
                    ]), startPoint: .top, endPoint: .bottom), lineWidth: 2)
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

struct Triangle: Shape {
    func path(in rect: CGRect) -> Path {
        var path = Path()
            
        path.move(to: CGPoint(x: rect.midX, y: rect.minY))
        path.addLine(to: CGPoint(x: rect.minX, y: rect.maxY))
        path.addLine(to: CGPoint(x: rect.maxX, y: rect.maxY))
        path.addLine(to: CGPoint(x: rect.midX, y: rect.minY))

        return path
    }
}

struct Arc: InsettableShape {
    
    var startAngle: Angle
    var endAngle: Angle
    var clockwise: Bool
    var insetAmount: CGFloat = 0
    
    func path(in rect: CGRect) -> Path {
        let rotationAdjustment = Angle.degrees(90)
        let modifiedStart = startAngle - rotationAdjustment
        let modifiedEnd = endAngle - rotationAdjustment
        var path = Path()
        
        path.addArc(center: CGPoint(x: rect.midX, y: rect.midY),
                    radius: rect.width / 2 - insetAmount,
                    startAngle: modifiedStart,
                    endAngle: modifiedEnd,
                    clockwise: !clockwise)
        
        return path
    }
    
    func inset(by amount: CGFloat) -> some InsettableShape {
        var arc = self
        arc.insetAmount += amount
        return arc
    }
}

struct Flower: Shape {
    
    // How much to move this petal away from the center
    var petalOffset: Double = -20
    
    // How wide to make each petal
    var petalWidth: Double = 100
    
    func path(in rect: CGRect) -> Path {
        var path = Path()
        
        // Count from 0 up to 2π, moving up π/8 each time
        for number in stride(from: 0, through: CGFloat.pi * 2, by: CGFloat.pi / 8) {
            // Rotate the petal by the current value of our loop
            let rotation = CGAffineTransform(rotationAngle: number)
            
            // Move the petal to be at the center of our view
            let position = rotation.concatenating(CGAffineTransform(translationX: rect.width / 2, y: rect.height / 2))
            
            // Create a path for this petal using our properties plus a fixed Y and height
            let originalPetal = Path(ellipseIn: CGRect(x: CGFloat(petalOffset), y: 0, width: CGFloat(petalWidth), height: rect.width / 2))
            
            // apply our rotation/position transform to the petal
            let rotatedPetal = originalPetal.applying(position)
            
            // add it to the main path
            path.addPath(rotatedPetal)
        }
        
        return path
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}

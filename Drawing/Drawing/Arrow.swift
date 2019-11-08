//
//  Arrow.swift
//  Drawing
//
//  Created by Angel Vázquez on 07/11/19.
//  Copyright © 2019 Ángel Vázquez. All rights reserved.
//

import SwiftUI

struct ArrowView: View {
    
    @State private var lineWidth: CGFloat = 3
    
    var body: some View {
        Arrow(lineWidth: lineWidth)
            .foregroundColor(.red)
            .frame(width: 300, height: 500)
            .animation(Animation.easeIn(duration: 2).repeatForever(autoreverses: true))
            .onAppear {
                self.lineWidth = 15
            }
            .navigationBarTitle("Challenges 1 & 2 - Arrow", displayMode: .inline)
    }
}

struct Arrow: InsettableShape {
    
    var lineWidth: CGFloat
    var insetAmount: CGFloat = 0
    
    var animatableData: CGFloat {
        get { lineWidth }
        set { self.lineWidth = newValue }
    }
    
    func path(in rect: CGRect) -> Path {
        var path = Path()
        
        path.move(to: CGPoint(x: rect.midX, y: 0 + insetAmount))
        path.addLine(to: CGPoint(x: 0 + insetAmount, y: rect.maxY / 3))
        path.addLine(to: CGPoint(x: rect.maxX / 4, y: rect.maxY / 3))
        path.addLine(to: CGPoint(x: rect.maxX / 4, y: rect.maxY - insetAmount))
        path.addLine(to: CGPoint(x: rect.maxX * 3 / 4, y: rect.maxY - insetAmount))
        path.addLine(to: CGPoint(x: rect.maxX * 3 / 4, y: rect.maxY / 3))
        path.addLine(to: CGPoint(x: rect.maxX - insetAmount, y: rect.maxY / 3))
        path.addLine(to: CGPoint(x: rect.midX, y: 0 + insetAmount))
    
        let strokedPath = path.strokedPath(StrokeStyle(lineWidth: lineWidth, lineCap: .round, lineJoin: .round))

        return strokedPath
    }
    
    func inset(by amount: CGFloat) -> some InsettableShape {
        var arrow = self
        arrow.insetAmount += amount
        return arrow
    }
}

struct ArrowView_Previews: PreviewProvider {
    static var previews: some View {
        ArrowView()
    }
}

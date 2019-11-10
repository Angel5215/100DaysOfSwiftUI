//
//  NumberButton.swift
//  MultiTables
//
//  Created by Angel Vázquez on 10/11/19.
//  Copyright © 2019 Ángel Vázquez. All rights reserved.
//

import SwiftUI

struct NumberButton: View {
    
    let number: Int
    let isCorrectAnswer: Bool
    var completionHandler: ((Int) -> Void)? = nil
    
    @State private var scaleAmount: CGFloat = 0
    
    var body: some View {
        Button(action: {
            withAnimation(Animation.easeInOut(duration: 0.5)) {
                self.scaleAmount = 3
                self.completionHandler?(self.number)
            }
        }, label: {
            ZStack {
                Text("\(number)")
                    .font(.system(size: 36, weight: .black, design: .rounded))
                    .frame(minWidth: 150, minHeight: 150)
                    .overlay(
                        RoundedRectangle(cornerRadius: 10)
                            .strokeBorder(style: StrokeStyle(lineWidth: 5, lineCap: .round, lineJoin: .round))
                    )
                    .foregroundColor(.random)
                
                Image(systemName: isCorrectAnswer ? "checkmark.circle.fill" : "xmark.circle.fill")
                    .renderingMode(.none)
                    .resizable()
                    .scaledToFit()
                    .foregroundColor(isCorrectAnswer ? .green : .red)
                    .scaleEffect(scaleAmount, anchor: .center)
            }
        })
    }
}

struct NumberButton_Previews: PreviewProvider {
    static var previews: some View {
        NumberButton(number: 5, isCorrectAnswer: true)
    }
}

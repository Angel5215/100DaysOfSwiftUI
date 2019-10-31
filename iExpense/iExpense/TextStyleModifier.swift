//
//  TextStyleModifier.swift
//  iExpense
//
//  Created by Angel Vázquez on 30/10/19.
//  Copyright © 2019 Ángel Vázquez. All rights reserved.
//

import SwiftUI

// MARK: - TextStyleModifier
struct TextStyleModifier: ViewModifier {
    
    var amount: Int

    var color: Color {
        switch amount {
        case 1..<10:
            return Color(.systemGreen)
        case 10..<100:
            return Color(.systemBlue)
        case 100...:
            return Color(.systemRed)
        default:
            return .clear
        }
    }
    
    func body(content: Content) -> some View {
        content
            .font(Font.system(.title, design: .rounded))
            .foregroundColor(color)
            .shadow(color: color, radius: 10)
    }
}

// MARK: - TextStyleModifier extension
extension View {
    func textStyle(for value: Int) -> some View {
        self.modifier(TextStyleModifier(amount: value))
    }
}

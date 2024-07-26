//
// ExpenseStyleModifier.swift
// Last modified by 'Ángel Vázquez' in 2024.
//

import SwiftUI

struct ExpenseStyleModifier: ViewModifier {
    let amount: Double

    func body(content: Content) -> some View {
        content
            .font(amount < 10 ? .system(.body) : .system(.body, weight: .bold))
            .foregroundStyle(amount < 100 ? Color.primary : Color.red)
            .background(amount < 100 ? .clear : .yellow.opacity(0.2))
    }
}

extension View {
    func expenseStyle(amount: Double) -> some View {
        modifier(ExpenseStyleModifier(amount: amount))
    }
}

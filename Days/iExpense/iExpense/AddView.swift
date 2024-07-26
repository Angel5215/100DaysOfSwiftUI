//
// AddView.swift
// Last modified by 'Ángel Vázquez' in 2024.
//

import SwiftUI

struct AddView: View {
    @State private var name = ""
    @State private var type = ExpenseItemType.personal
    @State private var amount = 0.0

    var currencyCode: String {
        Locale.current.currency?.identifier ?? "USD"
    }

    var expenses: Expenses

    @Environment(\.dismiss) var dismiss

    var body: some View {
        NavigationStack {
            Form {
                TextField("Name", text: $name)

                Picker("Type", selection: $type) {
                    ForEach(ExpenseItemType.allCases, id: \.self) {
                        Text($0.rawValue)
                    }
                }

                TextField("Amount", value: $amount, format: .currency(code: currencyCode))
                    .keyboardType(.decimalPad)
            }
            .navigationTitle("Add new expense")
            .toolbar {
                Button("Save") {
                    let item = ExpenseItem(name: name, type: type, amount: amount)
                    expenses.items.append(item)
                    dismiss()
                }
            }
        }
    }
}

#Preview {
    AddView(expenses: Expenses())
}

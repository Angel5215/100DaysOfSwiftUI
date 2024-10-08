//
// ContentView.swift
// Last modified by 'Ángel Vázquez' in 2024.
//

import SwiftUI

struct ItemSection {
    let title: String
    let items: [ExpenseItem]
}

struct ContentView: View {
    @State private var expenses = Expenses()
    // @State private var showingAddExpense = false

    var sections: [ItemSection] {
        [
            ItemSection(
                title: "Personal Expenses",
                items: expenses.items.filter { $0.type == "Personal" }
            ),
            ItemSection(
                title: "Business Expenses",
                items: expenses.items.filter { $0.type == "Business" }
            ),
        ]
    }

    var currencyCode: String {
        Locale.current.currency?.identifier ?? "USD"
    }

    var body: some View {
        NavigationStack {
            List {
                ForEach(sections, id: \.title) { section in
                    Section(section.title) {
                        ForEach(section.items) { item in
                            HStack {
                                Text(item.name)
                                    .font(.headline)
                                Spacer()
                                Text(item.amount, format: .currency(code: currencyCode))
                                    .expenseStyle(amount: item.amount)
                            }
                        }
                        .onDelete(perform: removeItems(from: section.items))
                    }
                }
            }
            .navigationTitle("iExpense")
            .toolbar {
                NavigationLink {
                    AddView(expenses: expenses)
                } label: {
                    Button("Add Expense", systemImage: "plus") {}
                }
//                Button("Add Expense", systemImage: "plus"){
//                    showingAddExpense = true
//                }
            }
//            .sheet(isPresented: $showingAddExpense) {
//                AddView(expenses: expenses)
//            }
        }
    }

    func removeItems(from array: [ExpenseItem]) -> (_ offsets: IndexSet) -> Void {
        { offsets in
            let ids = offsets.map { array[$0].id }
            expenses.items.removeAll { item in ids.contains(item.id) }
        }
    }
}

#Preview {
    ContentView()
}

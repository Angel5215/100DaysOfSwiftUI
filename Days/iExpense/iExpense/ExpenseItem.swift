//
// ExpenseItem.swift
// Last modified by 'Ángel Vázquez' in 2024.
//

import Foundation
import Observation

struct ExpenseItem: Identifiable {
    let id = UUID()
    let name: String
    let type: String
    let amount: Double
}

@Observable
class Expenses {
    var items = [ExpenseItem]()
}

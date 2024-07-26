//
// ExpenseItem.swift
// Last modified by 'Ángel Vázquez' in 2024.
//

import Foundation
import Observation

struct ExpenseItem: Identifiable, Codable {
    var id = UUID()
    let name: String
    let type: ExpenseItemType
    let amount: Double
}

enum ExpenseItemType: String, Codable, CaseIterable {
    case personal = "Personal"
    case business = "Business"
}

@Observable
class Expenses {
    var items = [ExpenseItem]() {
        didSet {
            if let encoded = try? JSONEncoder().encode(items) {
                UserDefaults.standard.set(encoded, forKey: "Items")
            }
        }
    }

    init() {
        if let savedItems = UserDefaults.standard.data(forKey: "Items") {
            if let decodedItems = try? JSONDecoder().decode([ExpenseItem].self, from: savedItems) {
                self.items = decodedItems
                return
            }
        }

        self.items = []
    }
}

//
//  ExpenseItem.swift
//  iExpense
//
//  Created by Angel Vázquez on 29/10/19.
//  Copyright © 2019 Ángel Vázquez. All rights reserved.
//

import Foundation

struct ExpenseItem: Identifiable {
    let id = UUID()
    let name: String
    let type: String
    let amount: Int
}

class Expenses: ObservableObject {
    @Published var items = [ExpenseItem]()
}

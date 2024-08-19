//
// Order.swift
// Last modified by 'Ángel Vázquez' in 2024.
//

import Observation

@Observable
class Order {
    static let types = ["Vanilla", "Strawberry", "Chocolate", "Rainbow"]

    var type = 0
    var quantity = 3

    var specialRequestEnabled = false
    var extraFrosting = false
    var addSprinkles = false
}

//
// Order.swift
// Last modified by 'Ángel Vázquez' in 2024.
//

import Foundation
import Observation

@Observable
class Order {
    static let types = ["Vanilla", "Strawberry", "Chocolate", "Rainbow"]

    var type = 0
    var quantity = 3

    var specialRequestEnabled = false {
        didSet {
            if specialRequestEnabled == false {
                extraFrosting = false
                addSprinkles = false
            }
        }
    }

    var extraFrosting = false
    var addSprinkles = false

    var name = ""
    var streetAddress = ""
    var city = ""
    var zip = ""

    var hasValidAddress: Bool {
        if name.isEmpty || streetAddress.isEmpty || city.isEmpty || zip.isEmpty {
            false
        } else {
            true
        }
    }

    var cost: Decimal {
        var finalCost = Decimal(quantity) * 2
        finalCost += Decimal(type) / 2

        if extraFrosting {
            finalCost += Decimal(quantity)
        }

        if addSprinkles {
            finalCost += Decimal(quantity) / 2
        }

        return finalCost
    }
}

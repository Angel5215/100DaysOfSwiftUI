//
// Order.swift
// Last modified by 'Ángel Vázquez' in 2024.
//

import Foundation
import Observation

@Observable
class Order: Codable {
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

extension Order {
    enum CodingKeys: String, CodingKey {
        case _type = "type"
        case _quantity = "quantity"
        case _specialRequestEnabled = "specialRequestEnabled"
        case _extraFrosting = "extraFrosting"
        case _addSprinkles = "addSprinkles"
        case _name = "name"
        case _city = "city"
        case _streetAddress = "streetAddress"
        case _zip = "zip"
    }
}

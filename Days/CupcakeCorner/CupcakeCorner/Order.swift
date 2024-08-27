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
    var address = Address()

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

    func saveAddressToUserDefaults() {
        if let encoded = try? JSONEncoder().encode(address) {
            UserDefaults.standard.set(encoded, forKey: "UserAddress")
        }
    }

    // MARK: - Codable

    init() {
        if let data = UserDefaults.standard.data(forKey: "UserAddress"),
           let decoded = try? JSONDecoder().decode(Address.self, from: data)
        {
            self.address = decoded
        }
    }

    required init(from decoder: any Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        self.address = try Address(
            name: container.decode(String.self, forKey: CodingKeys._name),
            streetAddress: container.decode(String.self, forKey: CodingKeys._streetAddress),
            city: container.decode(String.self, forKey: CodingKeys._city),
            zip: container.decode(String.self, forKey: CodingKeys._zip)
        )
        self.type = try container.decode(Int.self, forKey: CodingKeys._type)
        self.quantity = try container.decode(Int.self, forKey: CodingKeys._quantity)
        self.specialRequestEnabled = try container.decode(Bool.self, forKey: CodingKeys._specialRequestEnabled)
        self.extraFrosting = try container.decode(Bool.self, forKey: CodingKeys._extraFrosting)
        self.addSprinkles = try container.decode(Bool.self, forKey: CodingKeys._addSprinkles)
    }

    func encode(to encoder: any Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)
        try container.encode(type, forKey: CodingKeys._type)
        try container.encode(quantity, forKey: CodingKeys._quantity)
        try container.encode(specialRequestEnabled, forKey: CodingKeys._specialRequestEnabled)
        try container.encode(extraFrosting, forKey: CodingKeys._extraFrosting)
        try container.encode(addSprinkles, forKey: CodingKeys._addSprinkles)
        try container.encode(address.name, forKey: CodingKeys._name)
        try container.encode(address.city, forKey: CodingKeys._city)
        try container.encode(address.streetAddress, forKey: CodingKeys._streetAddress)
        try container.encode(address.zip, forKey: CodingKeys._zip)
    }

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

    // MARK: - Helpers

    struct Address: Codable {
        var name = ""
        var streetAddress = ""
        var city = ""
        var zip = ""

        var isValid: Bool {
            let emptyFields = [name, streetAddress, city, zip]
                .map { $0.trimmingCharacters(in: .whitespacesAndNewlines).isEmpty }
            return !emptyFields.contains(true)
        }
    }
}

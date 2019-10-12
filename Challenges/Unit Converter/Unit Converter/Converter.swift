//
//  Converter.swift
//  Unit Converter
//
//  Created by Angel Vázquez on 12/10/19.
//  Copyright © 2019 Ángel Vázquez. All rights reserved.
//

import Foundation

struct Converter {
    func conversion(from first: Measurement<Dimension>, to second: Dimension, numberOfDecimals: Int = 2) -> String {
        let result = first.converted(to: second)
        return String(format: "%.\(numberOfDecimals)f [%@]", result.value, result.unit.symbol)
    }
    
    static func dimension(for type: String) -> Dimension? {
        switch type {
        case "celsius":
            return UnitTemperature.celsius
        case "fahrenheit":
            return UnitTemperature.fahrenheit
        case "kelvin":
            return UnitTemperature.kelvin
        case "meters":
            return UnitLength.meters
        case "kilometers":
            return UnitLength.kilometers
        case "feet":
            return UnitLength.feet
        case "yards":
            return UnitLength.yards
        case "miles":
            return UnitLength.miles
        case "seconds":
            return UnitDuration.seconds
        case "minutes":
            return UnitDuration.minutes
        case "hours":
            return UnitDuration.hours
        case "days":
            return UnitDuration(symbol: "days", converter: UnitConverterLinear(coefficient: 86_400))
        case "milliliters":
            return UnitVolume.milliliters
        case "liters":
            return UnitVolume.liters
        case "cups":
            return UnitVolume.cups
        case "pints":
            return UnitVolume.pints
        case "gallons":
            return UnitVolume.gallons
        default:
            return nil
        }
    }
}

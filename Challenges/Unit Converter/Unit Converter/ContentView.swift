//
//  ContentView.swift
//  Unit Converter
//
//  Created by Angel Vázquez on 11/10/19.
//  Copyright © 2019 Ángel Vázquez. All rights reserved.
//

import SwiftUI

struct ContentView: View {
    
    // MARK: - State properties
    @State private var unitType = 0
    @State private var amount = ""
    @State private var firstUnit = ""
    @State private var secondUnit = ""
    
    // MARK: - Properties
    private let possibleUnits = ["temperature", "length", "time", "volume"]
    private let unitSelection = [
        ["celsius", "fahrenheit", "kelvin"],
        ["meters", "kilometers", "feet", "yards", "miles"],
        ["seconds", "minutes", "hours", "days"],
        ["milliliters", "liters", "cups", "pints", "gallons"]
    ]
    
    // MARK: - Computed properties
    var result: String {
        let converter = Converter()
        let currentList = unitSelection[unitType]
        
        guard let amount = Double(amount) else {
            return "Invalid input. Type a number."
        }
        
        guard let firstDimension = Converter.dimension(for: firstUnit),
            let secondDimension = Converter.dimension(for: secondUnit),
            [firstUnit, secondUnit].allSatisfy(currentList.contains) else {
            return "Unit has not been selected"
        }
        
        let measurement = Measurement(value: amount, unit: firstDimension)
        return converter.conversion(from: measurement, to: secondDimension)
    }
    
    
    // MARK: - View protocol
    var body: some View {
        NavigationView {
            Form {
                Section(header: Text("Please select a unit")) {
                    Picker("Units", selection: $unitType) {
                        ForEach(0 ..< possibleUnits.count) {
                            Text(self.possibleUnits[$0])
                        }
                    }
                    .pickerStyle(SegmentedPickerStyle())
                }
                
                inputData
                
                Section(header: Text("Result")) {
                    Text(result)
                }
            }
            .navigationBarTitle("Unit converter")
        }
    }
    
    var inputData: some View {
        Section(header: Text("Input data")) {
            TextField("Type an amount", text: $amount)
                .keyboardType(.numbersAndPunctuation)
            
            Picker("First unit", selection: $firstUnit) {
                ForEach(self.unitSelection[unitType], id: \.self) {
                    Text($0)
                }
            }
            
            Picker("Second unit", selection: $secondUnit) {
                ForEach(self.unitSelection[unitType], id: \.self) {
                    Text($0)
                }
            }
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}

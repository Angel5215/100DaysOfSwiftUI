//
// ContentView.swift
// Last modified by 'Ángel Vázquez' in 2024.
//

import SwiftUI

struct ContentView: View {
    private let units = ["meters", "kilometers", "feet", "yards", "miles"]

    @State private var inputUnit = "meters"
    @State private var outputUnit = "kilometers"
    @State private var inputValue = 0.0

    @FocusState private var isFocused: Bool

    private var result: Double {
        switch outputUnit {
        case "kilometers": inputInMeters / 1000
        case "feet": inputInMeters / 0.3048
        case "yards": inputInMeters / 0.9144
        case "miles": inputInMeters / 1609.34
        default: inputInMeters
        }
    }

    private var inputInMeters: Double {
        switch inputUnit {
        case "kilometers": inputValue * 1000
        case "feet": inputValue * 0.3048
        case "yards": inputValue * 0.9144
        case "miles": inputValue * 1609.34
        default: inputValue
        }
    }

    var body: some View {
        NavigationStack {
            Form {
                Section("Input value") {
                    TextField("Type your input value", value: $inputValue, format: .number)
                        .keyboardType(.decimalPad)
                        .focused($isFocused)
                }

                Section("Unit configuration") {
                    Picker("Input unit", selection: $inputUnit) {
                        ForEach(units, id: \.self) { unit in
                            Text(unit)
                        }
                    }

                    Picker("Output unit", selection: $outputUnit) {
                        ForEach(units, id: \.self) { unit in
                            Text(unit)
                        }
                    }
                }

                Section("Results") {
                    Text(result.formatted())
                }
            }
            .navigationTitle("UnitConverter")
            .toolbar {
                if isFocused {
                    Button("Done") {
                        isFocused = false
                    }
                }
            }
        }
    }
}

#Preview {
    ContentView()
}

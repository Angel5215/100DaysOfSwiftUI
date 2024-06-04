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
        0
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
                    Text(result, format: .number)
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

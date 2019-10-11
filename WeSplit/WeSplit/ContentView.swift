//
//  ContentView.swift
//  WeSplit
//
//  Created by Angel Vázquez on 08/10/19.
//  Copyright © 2019 Ángel Vázquez. All rights reserved.
//

import SwiftUI

// MARK: - ContentView
struct ContentView: View {
    
    // MARK: - Properties
    /// Cost of the check.
    @State private var checkAmount = ""
    
    /// Index for the number of people sharing the cost in a picker.
    @State private var numberOfPeople = 2
    
    /// How much tip people want to leave. Mapped to an index of `tipPercentages`
    @State private var tipPercentage = 2
    
    /// Possible tip sizes.
    let tipPercentages = [10, 15, 20, 25, 0]
    
    // MARK: - Computed properties
    var totalPerPerson: Double {
        let peopleCount = Double(numberOfPeople)
        let finalCount = peopleCount > 0 ? peopleCount : 2
        let amountPerPerson = totalAmount / finalCount
        return amountPerPerson
    }
    
    var totalAmount: Double {
        let tipSelection = Double(tipPercentages[tipPercentage])
        let orderAmount = Double(checkAmount) ?? 0
        
        let tipValue = orderAmount / 100 * tipSelection
        let grandTotal = orderAmount + tipValue
        return grandTotal
    }
    
    var body: some View {
        NavigationView {
            Form {
                Section {
                    TextField("Amount", text: $checkAmount)
                        .keyboardType(.decimalPad)
                    
                    Stepper("Number of people: \(numberOfPeople)", value: $numberOfPeople, in: 2 ... 100)
                }
                
                Section(header: Text("How much tip do you want to leave?")) {
                    Picker("Tip percentage", selection: $tipPercentage) {
                        ForEach(0 ..< tipPercentages.count) {
                            Text("\(self.tipPercentages[$0])%")
                        }
                    }
                    .pickerStyle(SegmentedPickerStyle())
                }
                
                // MARK: - Challenge 1
                Section(header: Text("Amount per person")) {
                    Text("$\(totalPerPerson, specifier: "%.2f")")
                }
                
                // MARK: - Challenge 2
                Section(header: Text("Total amount")) {
                    Text("$\(totalAmount, specifier: "%.2f")")
                }
            }
            .navigationBarTitle("WeSplit")
        }
    }
}

// MARK: - Previews
struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}

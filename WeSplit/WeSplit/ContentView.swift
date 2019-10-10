//
//  ContentView.swift
//  WeSplit
//
//  Created by Angel Vázquez on 08/10/19.
//  Copyright © 2019 Ángel Vázquez. All rights reserved.
//

import SwiftUI

struct ContentView: View {
    
    /// Cost of the check.
    @State private var checkAmount = ""
    
    /// Number of people sharing the cost.
    @State private var numberOfPeople = 2
    
    /// How much tip people want to leave. Mapped to an index of `tipPercentages`
    @State private var tipPercentage = 2
    
    /// Possible tip sizes.
    let tipPercentages = [10, 15, 20, 25, 0]
    
    var body: some View {
        Form {
            Section {
                TextField("Amount", text: $checkAmount)
                    .keyboardType(.decimalPad)
            }
            
            Section {
                Text("$\(checkAmount)")
            }
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}

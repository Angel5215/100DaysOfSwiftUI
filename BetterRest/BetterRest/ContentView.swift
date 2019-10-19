//
//  ContentView.swift
//  BetterRest
//
//  Created by Angel Vázquez on 18/10/19.
//  Copyright © 2019 Ángel Vázquez. All rights reserved.
//

import SwiftUI

struct ContentView: View {
    
    @State private var sleepAmount = 8.0
    @State private var wakeUp = Date()
    
    var body: some View {
        VStack {
            Stepper(value: $sleepAmount, in: 4...12, step: 0.25) {
                Text("\(sleepAmount, specifier: "%g") hours")
            }
            
            
            DatePicker("Please enter a date",
                       selection: $wakeUp,
                       in: Date()...,
                       displayedComponents: .hourAndMinute)
                .labelsHidden()
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}

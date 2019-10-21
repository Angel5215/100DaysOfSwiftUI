//
//  ContentView.swift
//  BetterRest
//
//  Created by Angel Vázquez on 18/10/19.
//  Copyright © 2019 Ángel Vázquez. All rights reserved.
//

import SwiftUI

struct ContentView: View {
    
    @State private var wakeUp = defaultWakeTime
    @State private var sleepAmount = 8.0
    @State private var coffeeAmount = 0
    
    static var defaultWakeTime: Date {
        var components = DateComponents()
        components.hour = 7
        components.minute = 0
        return Calendar.current.date(from: components) ?? Date()
    }
    
    var pickerMessage: String {
        if coffeeAmount == 1 {
            return "1 cup"
        } else {
            return "\(coffeeAmount) cups"
        }
    }
    
    var body: some View {
        NavigationView {
            VStack(spacing: 16) {
                VStack {
                    Text("Your ideal bedtime is...")
                        .font(.body)
                        .padding([.top, .leading, .trailing])
                    Text(calculateBedtime())
                        .font(.largeTitle)
                        .padding([.leading, .trailing, .bottom])
                }
                .foregroundColor(Color(.label))
                .clipShape(RoundedRectangle(cornerRadius: 10))
                .overlay(RoundedRectangle(cornerRadius: 10).stroke(lineWidth: 2).foregroundColor(Color(.label)))
                .shadow(color: Color(.label), radius: 3)
                
                Form {
                    Section(header: Text("When do you want to wake up?").font(.headline)) {
                        DatePicker("Please enter a time", selection: $wakeUp, displayedComponents: .hourAndMinute)
                            .labelsHidden()
                            .datePickerStyle(WheelDatePickerStyle())
                    }
                    
                    Section(header: Text("Desired amount of sleep").font(.headline)) {
                        Stepper(value: $sleepAmount, in: 4...12, step: 0.25) {
                            Text("\(sleepAmount, specifier: "%g") hours")
                        }
                    }
                    
                    Section(header: Text("Daily coffee intake").font(.headline)) {
                        Picker("Cup amount", selection: $coffeeAmount) {
                            ForEach(1 ..< 21) {
                                Text(self.pickerMessage(for: $0))
                            }
                        }
                    }
                }
            }
            .navigationBarTitle("BetterRest")
        }
        .background(Color.red)
    }
    
    func calculateBedtime() -> String {
        let model = SleepCalculator()
        let components = Calendar.current.dateComponents([.hour, .minute], from: wakeUp)
        let hour = (components.hour ?? 0) * 60 * 60
        let minute = (components.minute ?? 0) * 60
        
        do {
            let prediction = try model.prediction(wake: Double(hour + minute),
                                                  estimatedSleep: sleepAmount,
                                                  coffee: Double(coffeeAmount + 1))
            
            let sleepTime = wakeUp - prediction.actualSleep
            let formatter = DateFormatter()
            formatter.timeStyle = .short
            return formatter.string(from: sleepTime)
        } catch {
            return "Sorry, there was a problem calculating your bedtime."
        }
    }
    
    func pickerMessage(for numberOfCups: Int) -> String {
        if numberOfCups == 1 {
            return "1 cup"
        } else {
            return "\(numberOfCups) cups"
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}

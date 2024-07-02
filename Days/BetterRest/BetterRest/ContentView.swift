//
// ContentView.swift
// Last modified by 'Ángel Vázquez' in 2024.
//

import CoreML
import SwiftUI

struct ContentView: View {
    @State private var wakeUp = Self.defaultWakeTime
    @State private var sleepAmount = 8.0
    @State private var coffeeAmount = 1

    static var defaultWakeTime: Date {
        var components = DateComponents()
        components.hour = 7
        components.minute = 0
        return Calendar.current.date(from: components) ?? .now
    }

    var body: some View {
        NavigationStack {
            Form {
                Section("When do you want to wake up?") {
                    DatePicker(
                        "Please enter a time",
                        selection: $wakeUp,
                        displayedComponents: .hourAndMinute
                    )
                    // .labelsHidden() // Hides date picker label but not for VoiceOver users.
                }

                Section("Desired amount of sleep") {
                    Stepper(
                        "\(sleepAmount.formatted()) hours",
                        value: $sleepAmount,
                        in: 4 ... 12,
                        step: 0.25
                    )
                }

                Section("Daily coffee intake") {
                    Picker("Select how many cups", selection: $coffeeAmount) {
                        ForEach(1 ... 20, id: \.self) {
                            Text("^[\($0) cup](inflect: true)")
                        }
                    }
                    .pickerStyle(.navigationLink)
                }

                VStack {
                    bedtime
                }
                .frame(maxWidth: /*@START_MENU_TOKEN@*/ .infinity/*@END_MENU_TOKEN@*/, maxHeight: .infinity)
                .listRowInsets(EdgeInsets())
                .background(Color(UIColor.systemGroupedBackground))
            }
            .navigationTitle("BetterRest")
        }
    }

    var bedtime: some View {
        if let sleepTime = try? calculateBedtime() {
            VStack(alignment: .center) {
                Text("Your ideal bedtime is...")
                    .font(.callout)
                Text(sleepTime.formatted(date: .omitted, time: .shortened))
                    .font(.largeTitle.weight(.bold))
                    .foregroundStyle(.blue)
            }
        } else {
            VStack(alignment: .center) {
                Text("Error")
                    .font(.title.weight(.bold))
                    .foregroundStyle(.red)
                Text("There was a problem calculating your bedtime.")
            }
        }
    }

    func calculateBedtime() throws -> Date {
        let config = MLModelConfiguration()
        let model = try SleepCalculator(configuration: config)

        let components = Calendar.current.dateComponents([.hour, .minute], from: wakeUp)
        let hour = (components.hour ?? 0) * 60 * 60
        let minute = (components.minute ?? 0) * 60

        let prediction = try model.prediction(
            wake: Double(hour + minute),
            estimatedSleep: sleepAmount,
            coffee: Double(coffeeAmount)
        )
        let sleepTime = wakeUp - prediction.actualSleep

        return sleepTime
    }
}

#Preview {
    ContentView()
}

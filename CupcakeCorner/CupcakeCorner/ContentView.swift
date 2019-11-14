//
//  ContentView.swift
//  CupcakeCorner
//
//  Created by Angel Vázquez on 10/11/19.
//  Copyright © 2019 Ángel Vázquez. All rights reserved.
//

import SwiftUI

struct ContentView: View {
    
    @ObservedObject var order = CCOrder()
    
    var body: some View {
        NavigationView {
            Form {
                Section {
                    Picker("Select your cake type", selection: $order.current.type) {
                        ForEach(0..<Order.types.count, id: \.self) {
                            Text(Order.types[$0])
                        }
                    }
                    
                    Stepper(value: $order.current.quantity, in: 3...20) {
                        Text("Number of cakes: \(order.current.quantity)")
                    }
                }
                
                Section {
                    Toggle(isOn: $order.current.specialRequestEnabled.animation()) {
                        Text("Any special requests?")
                    }
                    
                    if order.current.specialRequestEnabled {
                        Toggle(isOn: $order.current.extraFrosting) {
                            Text("Add extra frosting")
                        }
                        
                        Toggle(isOn: $order.current.addSprinkles) {
                            Text("Add extra sprinkles")
                        }
                    }
                }
                
                Section {
                    NavigationLink(destination: AddressView(order: order)) {
                        Text("Delivery details")
                    }
                }
            }
            .navigationBarTitle("Cupcake Corner")
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}

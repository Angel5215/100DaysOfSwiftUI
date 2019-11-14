//
//  AddressView.swift
//  CupcakeCorner
//
//  Created by Angel Vázquez on 11/11/19.
//  Copyright © 2019 Ángel Vázquez. All rights reserved.
//

import SwiftUI

struct AddressView: View {
    
    @ObservedObject var order: CCOrder
    
    var body: some View {
        Form {
            Section {
                TextField("Name", text: $order.current.name)
                TextField("Street Address", text: $order.current.streetAddress)
                TextField("City", text: $order.current.city)
                TextField("Zip", text: $order.current.zip)
            }

            Section {
                NavigationLink(destination: CheckoutView(order: order)) {
                    Text("Check out")
                }
            }
            .disabled(order.current.hasValidAddress == false)
        }
        .navigationBarTitle("Delivery details", displayMode: .inline)
    }
}

struct AddressView_Previews: PreviewProvider {
    static var previews: some View {
        AddressView(order: CCOrder())
    }
}

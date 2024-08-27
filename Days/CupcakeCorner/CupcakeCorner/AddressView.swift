//
// AddressView.swift
// Last modified by 'Ángel Vázquez' in 2024.
//

import SwiftUI

struct AddressView: View {
    @Bindable var order: Order

    var body: some View {
        Form {
            Section {
                TextField("Name", text: $order.address.name)
                TextField("Street Address", text: $order.address.streetAddress)
                TextField("City", text: $order.address.city)
                TextField("Zip", text: $order.address.zip)
            }

            Section {
                NavigationLink("Check out") {
                    CheckoutView(order: order)
                        .onAppear(perform: order.saveAddressToUserDefaults)
                }
            }
            .disabled(order.address.isValid == false)
        }
    }
}

#Preview {
    AddressView(order: Order())
}

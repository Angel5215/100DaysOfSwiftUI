//
//  AddressView.swift
//  CupcakeCorner
//
//  Created by Angel Vázquez on 11/11/19.
//  Copyright © 2019 Ángel Vázquez. All rights reserved.
//

import SwiftUI

struct AddressView: View {
    
    @ObservedObject var order: Order
    
    var body: some View {
        Text("Hello World")
    }
}

struct AddressView_Previews: PreviewProvider {
    static var previews: some View {
        AddressView(order: Order())
    }
}

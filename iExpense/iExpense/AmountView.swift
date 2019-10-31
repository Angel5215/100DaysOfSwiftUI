//
//  AmountView.swift
//  iExpense
//
//  Created by Angel Vázquez on 30/10/19.
//  Copyright © 2019 Ángel Vázquez. All rights reserved.
//

import SwiftUI

struct AmountView: View {
    
    var value: Int
    
    var body: some View {
        Text("$\(value)")
            .textStyle(for: value)
    }
}

struct AmountView_Previews: PreviewProvider {
    static var previews: some View {
        AmountView(value: 100)
    }
}

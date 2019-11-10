//
//  NumberButton.swift
//  MultiTables
//
//  Created by Angel Vázquez on 10/11/19.
//  Copyright © 2019 Ángel Vázquez. All rights reserved.
//

import SwiftUI

struct NumberButton: View {
    
    let number: Int
    var completionHandler: ((Int) -> Void)? = nil
    
    var body: some View {
        Button(action: {
            self.completionHandler?(self.number)
        }, label: {
            Text("\(number)")
                .font(.system(size: 36, weight: .black, design: .rounded))
                .frame(minWidth: 150, minHeight: 150)
                .overlay(
                    RoundedRectangle(cornerRadius: 10)
                        .strokeBorder(style: StrokeStyle(lineWidth: 5, lineCap: .round, lineJoin: .round))
                )
                .foregroundColor(.random)
        })
    }
}

struct NumberButton_Previews: PreviewProvider {
    static var previews: some View {
        NumberButton(number: 5)
    }
}

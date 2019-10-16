//
//  ContentView.swift
//  ViewsAndModifiers
//
//  Created by Angel Vázquez on 15/10/19.
//  Copyright © 2019 Ángel Vázquez. All rights reserved.
//

import SwiftUI

struct ContentView: View {
    var body: some View {
        Text("Hello world!")
            .padding()
            .background(Color.red)
            .padding()
            .background(Color.blue)
            .padding()
            .background(Color.green)
            .padding()
            .background(Color.yellow)
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}

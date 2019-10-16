//
//  ContentView.swift
//  ViewsAndModifiers
//
//  Created by Angel Vázquez on 15/10/19.
//  Copyright © 2019 Ángel Vázquez. All rights reserved.
//

import SwiftUI

struct ContentView: View {
    
    @State private var isYellow = false
    
    var body: some View {
        VStack(spacing: 40) {
            VStack(spacing: 20) {
                Text("Gryffindor")
                Text("Hufflepuff")
                Text("Ravenclaw")
                Text("Slytherin")
            }
            .font(.title)
            .padding()
            .background(isYellow ? Color.yellow : Color.green)
            
            Button("Change background") {
                self.isYellow.toggle()
            }
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}

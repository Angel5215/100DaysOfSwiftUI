//
//  ContentView.swift
//  GuessTheFlag
//
//  Created by Angel Vázquez on 13/10/19.
//  Copyright © 2019 Ángel Vázquez. All rights reserved.
//

import SwiftUI

struct ContentView: View {
    var body: some View {
        VStack {
            HStack {
                Text("11")
                Text("12")
                Text("13")
            }
            
            HStack {
                Text("21")
                Text("22")
                Text("23")
            }
            
            HStack {
                Text("31")
                Text("32")
                Text("33")
            }
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}

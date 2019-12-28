//
//  ContentView.swift
//  SnowSeeker
//
//  Created by Angel Vázquez on 27/12/19.
//  Copyright © 2019 Ángel Vázquez. All rights reserved.
//

import SwiftUI

struct ContentView: View {
    var body: some View {
        NavigationView {
            NavigationLink(destination: Text("New secondary")) {
                Text("Hello, World!")
            }
            .navigationBarTitle("Primary")

            Text("Secondary")
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}

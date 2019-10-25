//
//  ContentView.swift
//  Animations
//
//  Created by Angel Vázquez on 24/10/19.
//  Copyright © 2019 Ángel Vázquez. All rights reserved.
//

import SwiftUI

struct ContentView: View {
    var body: some View {
        NavigationView {
            List {
                NavigationLink("Pulsating animation", destination: PulsatingAnimation())
                    .labelsHidden()
                NavigationLink("Animating bindings", destination: BindingAnimation())
            }
            .navigationBarTitle("Animations")
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}

//
//  ContentView.swift
//  GuessTheFlag
//
//  Created by Angel Vázquez on 13/10/19.
//  Copyright © 2019 Ángel Vázquez. All rights reserved.
//

import SwiftUI

struct ContentView: View {
    
    @State private var showingAlert = false
    
    var countries = ["Estonia", "France", "Germany", "Ireland", "Italy", "Nigeria", "Poland", "Russia", "Spain", "UK", "US"]
    var correctAnswer = Int.random(in: 0...2)
    
    var body: some View {
        ZStack {
            
            Color.blue.edgesIgnoringSafeArea(.all)
                    
            VStack(spacing: 30) {
                VStack {
                    Text("Tap the flag of")
                    Text(countries[correctAnswer])
                }
                
                ForEach(0 ..< 3) { number in
                    Button(action: {
                        
                    }, label: {
                        Image(self.countries[number])
                            .renderingMode(.original)
                    })
                }
                
                Spacer()
            }
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}

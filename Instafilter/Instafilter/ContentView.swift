//
//  ContentView.swift
//  Instafilter
//
//  Created by Angel Vázquez on 23/11/19.
//  Copyright © 2019 Ángel Vázquez. All rights reserved.
//

import SwiftUI

struct ContentView: View {
    
    @State private var blurAmount: CGFloat = 0 {
        didSet {
            print("The new value is \(blurAmount)")
        }
    }
    
    var body: some View {
        
        let blur = Binding<CGFloat>(
            get: {
                self.blurAmount
            },
            set: {
                self.blurAmount = $0
                print("New value is \(self.blurAmount)")
            }
        )
        
        return VStack {
            Text("Hello, World!")
                .blur(radius: blurAmount)

            Slider(value: blur, in: 0...20)
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}

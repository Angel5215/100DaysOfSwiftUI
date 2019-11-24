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
        VStack {
            Text("Hello, World!")
                .blur(radius: blurAmount)

            Slider(value: $blurAmount, in: 0...20)
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}

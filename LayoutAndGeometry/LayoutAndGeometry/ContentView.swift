//
//  ContentView.swift
//  LayoutAndGeometry
//
//  Created by Angel Vázquez on 23/12/19.
//  Copyright © 2019 Ángel Vázquez. All rights reserved.
//

import SwiftUI

struct ContentView: View {
    var body: some View {
       VStack(alignment: .leading) {
           ForEach(0..<10) { position in
               Text("Number \(position)")
                   .alignmentGuide(.leading) { _ in CGFloat(position) * -10 }
           }
       }
       .background(Color.red)
       .frame(width: 400, height: 400)
       .background(Color.blue)
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}

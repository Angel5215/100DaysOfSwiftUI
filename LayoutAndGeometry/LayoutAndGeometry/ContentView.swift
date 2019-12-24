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
        HStack(alignment: .midAccountAndName) {
            VStack {
                ForEach(0..<5) { Text("Sample text \($0 + 1)")}
                Text("@angel_5215")
                    .alignmentGuide(.midAccountAndName) { d in d[VerticalAlignment.center] }
                Image("bird")
                    .resizable()
                    .frame(width: 64, height: 64)
                ForEach(0..<5) { Text("Sample text \($0 + 1)")}
            }

            VStack {
                Text("Full name:")
                Text("ANGEL VÁZQUEZ")
                    .alignmentGuide(.midAccountAndName) { d in d[VerticalAlignment.center] }
                    .font(.title)
                ForEach(0..<20) { Text("Sample text \($0 + 1)")}
            }
        }
    }
}

extension VerticalAlignment {
    enum MidAccountAndName: AlignmentID {
        static func defaultValue(in d: ViewDimensions) -> CGFloat {
            d[.top]
        }
    }
    
    static let midAccountAndName = VerticalAlignment(MidAccountAndName.self)
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}

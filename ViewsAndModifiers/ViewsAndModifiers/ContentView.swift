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
        VStack(spacing: 10) {
            
            Text("Views and Modifiers")
                .blueTitled()
                
            CapsuleText(text: "First")
            CapsuleText(text: "Second")
            
            ZStack {
                Color.blue
                .frame(width: 300, height: 200)
                .watermarked(with: "Hacking with Swift")
                
                GridStack(rows: 5, columns: 4) { row, col in
                    Text("(\(row),\(col))")
                }
                .padding(10)
                .background(Color.yellow)
                .font(.system(.headline, design: .monospaced))
            }
        }
    }
}

struct CapsuleText: View {
    var text: String
    
    var body: some View {
        Text(text)
            .titleStyle()
    }
}

struct Title: ViewModifier {
    func body(content: Content) -> some View {
        content
            .font(.largeTitle)
            .foregroundColor(.white)
            .padding()
            .background(Color.blue)
            .clipShape(Capsule())
    }
}

struct Watermark: ViewModifier {
    
    var text: String
    
    func body(content: Content) -> some View {
        ZStack(alignment: .bottom) {
            content
            
            Text(text)
                .font(.caption)
                .foregroundColor(.white)
                .padding(5)
                .background(Color.black)
        }
    }
}

struct BlueTitle: ViewModifier {
    func body(content: Content) -> some View {
        content
            .font(.system(size: 30, weight: .black, design: .rounded))
            .foregroundColor(.blue)
    }
}

extension View {
    func titleStyle() -> some View {
        self.modifier(Title())
    }
    
    func watermarked(with text: String) -> some View {
        self.modifier(Watermark(text: text))
    }
    
    func blueTitled() -> some View {
        self.modifier(BlueTitle())
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}

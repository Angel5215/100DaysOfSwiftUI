//
//  Color+Greens.swift
//  Brain RPS
//
//  Created by Angel Vázquez on 17/10/19.
//  Copyright © 2019 Ángel Vázquez. All rights reserved.
//

import SwiftUI

extension Color {
    
    /// Initializes a color from a specific hex number in RGB format.
    /// - Parameter hexNumber: An RGB color in hexadecimal format (e.g. `0xFF00FF` for magenta).
    /// - Returns: A `Color` instance of the hex number. If it's greater than `0xFFFFFF`, returns
    /// `.white`; if it's lower than `0x000000`, returns `.black`
    init(hexNumber: Int) {
        if hexNumber >= 0xFFFFFF {
            self.init(.white)
        } else if hexNumber <= 0x000000 {
            self.init(.black)
        } else {
            let red = Double((hexNumber & 0xFF0000) >> 16) / 255
            let green = Double((hexNumber & 0x00FF00) >> 8) / 255
            let blue = Double(hexNumber & 0x0000FF) / 255
            self.init(red: red, green: green, blue: blue)
        }
    }
    
    static var darkGreen: Color { Color(hexNumber: 0x093009) }
    static var forestGreen: Color { Color(hexNumber: 0x0D3E10) }
    static var mughalGreen: Color { Color(hexNumber: 0x1F6032) }
    static var japaneseLaurel: Color { Color(hexNumber: 0x29773E) }
    static var seaGreen: Color { Color(hexNumber: 0x369457) }
    static var smokyBlack: Color { Color(hexNumber: 0x032202) }
}

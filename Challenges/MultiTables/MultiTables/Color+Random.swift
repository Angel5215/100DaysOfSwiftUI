//
//  Color+Random.swift
//  MultiTables
//
//  Created by Angel Vázquez on 10/11/19.
//  Copyright © 2019 Ángel Vázquez. All rights reserved.
//

import SwiftUI

extension Color {
    static var random: Color {
        Color(hue: Double.random(in: 0...1), saturation: 0.5, brightness: 0.8)
    }
    
    static var randomDark: Color {
        Color(hue: Double.random(in: 0...1), saturation: 0.2, brightness: 0.2)
    }
}

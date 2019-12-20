//
//  Card.swift
//  Flashzilla
//
//  Created by Angel Vázquez on 19/12/19.
//  Copyright © 2019 Ángel Vázquez. All rights reserved.
//

import Foundation

struct Card {
    let prompt: String
    let answer: String
    
    #if DEBUG
        static var example: Card {
            return Card(prompt: "Who played the 13th Doctor in Doctor Who?", answer: "Jodie Whittaker")
        }
    #endif
}

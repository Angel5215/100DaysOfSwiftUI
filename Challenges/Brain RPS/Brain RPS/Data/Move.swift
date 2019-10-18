//
//  Move.swift
//  Brain RPS
//
//  Created by Angel Vázquez on 17/10/19.
//  Copyright © 2019 Ángel Vázquez. All rights reserved.
//

import SwiftUI

enum Move: String, CaseIterable {
    case rock
    case paper
    case scissors
    
    var emoji: String {
        switch self {
        case .rock:
            return "🤘"
        case .paper:
            return "🤚"
        case .scissors:
            return "✌️"
        }
    }
    
    func wins(against otherMove: Move) -> Bool {
        switch (self, otherMove) {
        case (.rock, .paper), (.paper, .scissors), (.scissors, .rock):
            return false
        case (.rock, .rock), (.paper, .paper), (.scissors, .scissors):
            return false
        case (.rock, .scissors), (.paper, .rock), (.scissors, .paper):
            return true
        }
    }
}

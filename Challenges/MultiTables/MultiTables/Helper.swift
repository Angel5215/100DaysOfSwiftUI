//
//  Mode.swift
//  MultiTables
//
//  Created by Angel Vázquez on 10/11/19.
//  Copyright © 2019 Ángel Vázquez. All rights reserved.
//

import Foundation

/// Game includes two modes. You can select a `single` number to
/// practice or you can select multiple numbers using `upTo`.
enum Mode: String, CaseIterable {
    /// Practice the multiplication table of an specific number.
    case single
    /// Practice multiplication tables up to a selected number.
    case upTo
}

/// Game let players select how many questions they want to be asked.
/// A random selection of questions is determined by the cases of this
/// enumeration.
enum QuestionSelection: String, CaseIterable {
    case five
    case ten
    case twenty
    case all
}

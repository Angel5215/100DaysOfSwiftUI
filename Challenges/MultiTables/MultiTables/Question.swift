//
//  Question.swift
//  MultiTables
//
//  Created by Angel Vázquez on 10/11/19.
//  Copyright © 2019 Ángel Vázquez. All rights reserved.
//

import Foundation

/// Represents a multiplication question and its answer.
struct Question: CustomStringConvertible {
    let firstNumber: Int
    let secondNumber: Int
    var result: Int { firstNumber * secondNumber }

    /// Use any `Question` inside String interpolation, this property ensures it will
    /// be printed in a nice format.
    var description: String { "\(firstNumber) ✕ \(secondNumber)" }
}

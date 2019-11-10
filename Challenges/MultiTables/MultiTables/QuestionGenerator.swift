//
//  QuestionGenerator.swift
//  MultiTables
//
//  Created by Angel Vázquez on 10/11/19.
//  Copyright © 2019 Ángel Vázquez. All rights reserved.
//

import Foundation

struct QuestionGenerator {
    static func questions(for number: Int, mode: Mode, limitedTo selection: QuestionSelection) -> [Question] {
        var questions = [Question]()
        
        if mode == .single {
            for i in 1...10 {
                questions.append(Question(firstNumber: number, secondNumber: i))
            }
        } else {
            for i in 1...number {
                for j in 1...10 {
                    questions.append(Question(firstNumber: i, secondNumber: j))
                }
            }
        }
        
        questions.shuffle()
        
        switch selection {
        case .five:
            return Array(questions[..<5])
        case .ten:
            return Array(questions[..<10])
        case .twenty:
            if questions.count >= 20 {
                return Array(questions[..<20])
            } else {
                var repeatedArray = [[Question]](repeating: questions, count: 3).flatMap { $0 }
                repeatedArray.shuffle()
                return Array(repeatedArray[..<20])
            }
        default:
            return questions
        }
    }
}

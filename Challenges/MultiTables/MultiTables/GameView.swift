//
//  GameView.swift
//  MultiTables
//
//  Created by Angel Vázquez on 10/11/19.
//  Copyright © 2019 Ángel Vázquez. All rights reserved.
//

import SwiftUI

struct GameView: View {
    
    // MARK: - State properties
    @State private var currentQuestion = 0
    @State private var score = 0
    @State private var isGameFinished = false

    @Environment(\.presentationMode) var presentationMode
    
    // MARK: - Properties
    let questions: [Question]
    
    // MARK: - Initializers
    init(number: Int, mode: Mode, limitedTo selection: QuestionSelection) {
        self.questions = QuestionGenerator.questions(for: number, mode: mode, limitedTo: selection)
    }
    
    // MARK: - View Protocol
    var body: some View {
        VStack(spacing: 20) {
            Text("\(questions[currentQuestion].description) = ?")
                .font(.system(size: 40, weight: .heavy, design: .rounded))
            
            ForEach(generateRandomAnswers(for: questions[currentQuestion]), id: \.self) { answer in
                NumberButton(number: answer) {
                    guard self.currentQuestion != self.questions.count - 1 else {
                        self.isGameFinished = true
                        return
                    }
                    self.numberButtonTapped(answer: $0)
                }
            }
            
            Text("Question \(currentQuestion + 1) / \(questions.count)")
        }
        .alert(isPresented: $isGameFinished) {
            Alert(title: Text("Game Over"),
                  message: Text("Your score was \(score)"),
                  dismissButton: .default(Text("OK"), action: { self.presentationMode.wrappedValue.dismiss() }))
        }
    }
    
    private func generateRandomAnswers(for question: Question) -> [Int] {
        let correctAnswer = question.result
        let firstRandomAnswer = Int.random(in: correctAnswer / 5 ..< correctAnswer)
        let secondRandomAnswer = Int.random(in: correctAnswer + 1 ... correctAnswer * 5)
        let possibleAnswers = [correctAnswer, firstRandomAnswer, secondRandomAnswer]
        
        return possibleAnswers.shuffled()
    }
    
    private func numberButtonTapped(answer: Int) {
        if answer == questions[currentQuestion].result {
            score += 1
        } else {
            score -= 1
        }
        currentQuestion += 1
    }
}

struct GameView_Previews: PreviewProvider {
    static var previews: some View {
        GameView(number: 12, mode: .multiple, limitedTo: .ten)
    }
}

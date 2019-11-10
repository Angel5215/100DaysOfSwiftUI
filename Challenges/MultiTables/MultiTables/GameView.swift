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
    @State private var scaleAmount: CGFloat = 1

    @Environment(\.presentationMode) var presentationMode
    
    // MARK: - Properties
    let questions: [Question]
    
    // MARK: - Initializers
    init(number: Int, mode: Mode, limitedTo selection: QuestionSelection) {
        self.questions = QuestionGenerator.questions(for: number, mode: mode, limitedTo: selection)
    }
    
    // MARK: - View Protocol
    var body: some View {
        ZStack {
            LinearGradient(gradient: Gradient(colors: [.randomDark, .randomDark, .randomDark, .randomDark, .randomDark]), startPoint: .topLeading, endPoint: .bottomTrailing)
                .edgesIgnoringSafeArea(.all)
            
            if !isGameFinished {
                VStack(spacing: 20) {
                    Text("\(questions[currentQuestion].description) = ?")
                        .font(.system(size: 40, weight: .heavy, design: .rounded))
                        .foregroundColor(.white)
                    
                    ForEach(generateRandomAnswers(for: questions[currentQuestion]), id: \.self) { answer in
                        NumberButton(number: answer, isCorrectAnswer: answer == self.questions[self.currentQuestion].result) {
                            guard self.currentQuestion != self.questions.count - 1 else {
                                self.isGameFinished = true
                                return
                            }
                            self.numberButtonTapped(answer: $0)
                        }
                    }
                    
                    HStack(spacing: 20) {
                        Text("Question \(currentQuestion + 1) / \(questions.count)")
                            .foregroundColor(.white)
                            .font(.headline)
                        Text("Score: \(score)")
                            .foregroundColor(.white)
                            .font(.headline)
                    }
                }
                .padding([.top, .bottom])
            } else {
                VStack(spacing: 30) {
                    Text("GAME OVER!")
                        .font(.system(size: 40, weight: .heavy, design: .rounded))
                        .foregroundColor(.white)
                        .scaleEffect(CGSize(width: scaleAmount * 0.8, height: scaleAmount * 0.8), anchor: .center)
                        .animation(Animation.easeInOut.repeatForever(autoreverses: true))
                        .onAppear(perform: {
                            self.scaleAmount = 1.5
                        })
                
                    
                    Text("Your score was: \(score)")
                        .font(.headline)
                        .scaleEffect(CGSize(width: scaleAmount * 0.7, height: scaleAmount * 0.7), anchor: .center)
                        .animation(Animation.easeInOut.repeatForever(autoreverses: true))
                        .onAppear(perform: {
                            self.scaleAmount = 1.5
                        })
                        .foregroundColor(.white)
                    
                    Button(action: {
                        self.presentationMode.wrappedValue.dismiss()
                    }, label: {
                        Text("Close")
                            .foregroundColor(.white)
                            .padding(.horizontal, 30)
                            .padding(.vertical, 15)
                            .background(Color.blue)
                            .clipShape(Capsule())
                    })
                }
            }
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

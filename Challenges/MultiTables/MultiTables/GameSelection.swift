//
//  GameSelection.swift
//  MultiTables
//
//  Created by Angel Vázquez on 08/11/19.
//  Copyright © 2019 Ángel Vázquez. All rights reserved.
//

import SwiftUI

struct GameSelectionView: View {
    
    // MARK: - State properties
    @State private var currentMode = Mode.single
    @State private var numberOfQuestions = QuestionSelection.five
    @State private var currentNumber = 1
    
    // MARK: - Properties
    let availableNumbers = Array(1...12)
    let availableModes = Mode.allCases
    let availableQuestionSelection = QuestionSelection.allCases
        
    // MARK: - View protocol
    var body: some View {
        NavigationView {
            Form {
                Section(header: Text("Configuration")) {
                    Picker(selection: $currentMode, label: Text("Game mode")) {
                        ForEach(availableModes, id: \.self) { mode in
                            Text(mode.rawValue)
                        }
                    }
                    
                    Picker(selection: $numberOfQuestions, label: Text("How many questions?")) {
                        ForEach(availableQuestionSelection, id: \.self) { selection in
                            Text(selection.rawValue)
                        }
                    }
                    
                    Picker(selection: $currentNumber, label: Text(currentMode == .single ? "Number to practice" : "Numbers to practice")) {
                            ForEach(availableNumbers, id: \.self) { number in
                                Text("\(number)")
                            }
                    }
                }
                
                if currentMode == .single {
                    Text("Practice \(numberOfQuestions.rawValue) questions for the number \(currentNumber)")
                } else {
                    Text("Practice \(numberOfQuestions.rawValue) questions for all numbers up to \(currentNumber)")
                }
                
                Button("Start game") {
                    let questions = QuestionGenerator.questions(for: self.currentNumber,
                                                                mode: self.currentMode,
                                                                limitedTo: self.numberOfQuestions)
                    print("Count: \(questions.count)")
                    for question in questions {
                        print(">> \(question)")
                    }
                }
            }
            .navigationBarTitle("MultiTables", displayMode: .inline)
        }
    }
}

struct GameSelectionView_Previews: PreviewProvider {
    static var previews: some View {
        GameSelectionView()
    }
}

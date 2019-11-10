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
    @State private var currentNumber = 6
    @State private var isGameActive = false
    
    // MARK: - Properties
    let availableModes = Mode.allCases
    let availableQuestionSelection = QuestionSelection.allCases
    
    // MARK: - Computed properties
    var numberToPractice: String {
        if currentMode == .single {
            return "Selected number: \(currentNumber)"
        } else {
            return "Selected numbers: 1-\(currentNumber)"
        }
    }
        
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
                    
                    Stepper(numberToPractice, value: $currentNumber, in: 2...12)
                }
                
                Button("Start game") {
                    self.isGameActive.toggle()
                }
            }
            .navigationBarTitle("MultiTables", displayMode: .inline)
            .sheet(isPresented: $isGameActive) {
                GameView(number: self.currentNumber, mode: self.currentMode, limitedTo: self.numberOfQuestions)
            }
        }
    }
}

struct GameSelectionView_Previews: PreviewProvider {
    static var previews: some View {
        GameSelectionView()
    }
}

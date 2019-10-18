//
//  ContentView.swift
//  Brain RPS
//
//  Created by Angel Vázquez on 17/10/19.
//  Copyright © 2019 Ángel Vázquez. All rights reserved.
//

import SwiftUI

// MARK: - ContentView
struct ContentView: View {
    
    // MARK: - State properties
    /// Game selects a random integer to represent rock, paper and scissors.
    @State private var selectedMove = Int.random(in: 0 ... 2)
    
    /// Game prompt the user to whether win or lose.
    @State private var winPrompt = Bool.random()
    
    /// Score of the game.
    @State private var score = 0
    
    /// The game will end when this counter reaches 10.
    @State private var turnCounter = 1
    
    /// At the end of the game, an alert is shown with the score.
    @State private var scoreAlertIsShown = false
    
    /// Each turn shows an alert with a small message that contains
    /// whether the player answered correctly or not.
    @State private var answerAlertIsShown = false
    
    // MARK: - Properties
    let moves = ["Rock", "Paper", "Scissors"]
    
    // MARK: - View protocol
    var body: some View {
        Text("Hello World")
    }
}

// MARK: - ContentView preview
struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}

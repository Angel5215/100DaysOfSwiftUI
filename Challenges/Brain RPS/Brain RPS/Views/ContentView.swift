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
    @State private var gameMove = Int.random(in: 0 ... 2)
    
    /// Game prompt the user to whether win or lose.
    @State private var winPrompt = Bool.random()
    
    /// Score of the game.
    @State private var score = 0
    
    /// The game will end when this counter reaches 10.
    @State private var turnCounter = 1
    
    /// At the end of the game, an alert is shown with the score.
    @State private var scoreAlertIsShown = false
    
    // MARK: - Properties
    let moves: [Move] = [.rock, .paper, .scissors]
    
    private let backgroundColors: [Color] = [.smokyBlack, .mughalGreen, .smokyBlack]
    private let buttonColors: [Color] = [.seaGreen, .japaneseLaurel, .mughalGreen, .forestGreen, .darkGreen]
    
    
    // MARK: - View protocol
    var body: some View {
        NavigationView {
            ZStack {
                RadialGradient(gradient: Gradient(colors: backgroundColors), center: .topLeading, startRadius: 20, endRadius: 625)
                    .edgesIgnoringSafeArea(.all)
                
                VStack(spacing: 40) {
                    Text("Select a move to \(winPrompt ? "WIN" : "LOSE") against")
                        .font(Font.system(size: 28, weight: .black, design: .rounded))
                        .multilineTextAlignment(.center)
                        .padding([.top, .leading, .trailing], 30)
                        .foregroundColor(.white)
                    MoveView(type: moves[gameMove])
                        .font(.system(size: 20, weight: .semibold, design: .rounded))
                        .foregroundColor(.white)
                    HStack {
                        ForEach(0 ..< moves.count) { index in
                            Button(action: {
                                self.selectMove(at: index)
                            }, label: {
                                MoveView(type: self.moves[index], fontSize: 60)
                                    .font(.system(size: 15, weight: .semibold, design: .rounded))
                                    .padding(8)
                                    .foregroundColor(.white)
                                    .overlay(RoundedRectangle(cornerRadius: 20).stroke())
                                    .background(LinearGradient(gradient: Gradient(colors: self.buttonColors),
                                                               startPoint: .topLeading,
                                                               endPoint: .bottomTrailing))
                                    .clipShape(RoundedRectangle(cornerRadius: 20))
                                    .shadow(color: .black, radius: 3)
                            })
                        }
                    }
                    Spacer()
                }
                .alert(isPresented: $scoreAlertIsShown) {
                    Alert(title: Text("Game over"),
                          message: Text("You scored \(score) points!"),
                          dismissButton: .default(Text("Restart game"), action: restartGame))
                }
            }
            .navigationBarTitle("Round: \(turnCounter)", displayMode: .inline)
        }
    }
    
    private func selectMove(at index: Int) {
        scoreAlertIsShown = turnCounter >= 10
        let userSelection = moves[index]
        let gameSelection = moves[gameMove]
        switch (userSelection.wins(against: gameSelection), winPrompt) {
        case (true, true), (false, false):
            score += 1
        default:
            score -= 1
        }
        
        gameMove = Int.random(in: 0 ... 2)
        winPrompt = Bool.random()
        turnCounter += 1
    }
    
    private func restartGame() {
        turnCounter = 1
        gameMove = Int.random(in: 0 ... 2)
        winPrompt = Bool.random()
        score = 0
    }
}

// MARK: - ContentView preview
struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}

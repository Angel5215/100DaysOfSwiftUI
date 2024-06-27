//
// ContentView.swift
// Last modified by 'Ángel Vázquez' in 2024.
//

import SwiftUI

struct ContentView: View {
    private let moves = ["Rock", "Paper", "Scissors"]
    @State private var currentChoice = Int.random(in: 0 ..< 2)
    @State private var shouldPlayerWin = Bool.random()
    @State private var score = 0

    private var shouldPlayerWinText: String {
        if shouldPlayerWin {
            "win"
        } else {
            "lose"
        }
    }

    private var currentChoiceText: String {
        moves[currentChoice]
    }

    var body: some View {
        VStack {
            Text("Score: \(score)")

            Text("You should \(shouldPlayerWinText) against \(currentChoiceText)")

            VStack {
                Text("Select your move:")

                Button("Rock") {
                    updateScore(userMove: "Rock")
                }
                Button("Paper") {
                    updateScore(userMove: "Paper")
                }
                Button("Scissors") {
                    updateScore(userMove: "Scissors")
                }
            }
        }
    }

    private func result(for userMove: String, against systemMove: String, shouldWin: Bool) -> Bool {
        switch (shouldWin, userMove, systemMove) {
        case (true, "Rock", "Scissors"), (true, "Paper", "Rock"), (true, "Scissors", "Paper"):
            true
        case (false, "Rock", "Paper"), (false, "Paper", "Scissors"), (false, "Scissors", "Rock"):
            true
        default:
            false
        }
    }

    private func updateScore(userMove: String) {
        let systemMove = moves[currentChoice]
        if result(for: userMove, against: systemMove, shouldWin: shouldPlayerWin) {
            score += 1
        } else {
            score -= 1
        }

        shuffleMoves()
    }

    private func shuffleMoves() {
        currentChoice = Int.random(in: 0 ..< 2)
        shouldPlayerWin = Bool.random()
    }
}

#Preview {
    ContentView()
}

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
    @State private var currentTurn = 0
    @State private var isGameOver = false

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

                Button("🪨") {
                    updateScore(userMove: "Rock")
                }
                .padding()
                .frame(minWidth: 150)
                .background(.blue)
                .foregroundStyle(.white)
                .font(.system(size: 80))
                .clipShape(.capsule)
                .overlay(Capsule().stroke(.black, lineWidth: 2))
                Button("📃") {
                    updateScore(userMove: "Paper")
                }
                .padding()
                .frame(minWidth: 150)
                .background(.blue)
                .foregroundStyle(.white)
                .font(.system(size: 80))
                .clipShape(.capsule)
                .overlay(Capsule().stroke(.black, lineWidth: 2))
                Button("✂️") {
                    updateScore(userMove: "Scissors")
                }
                .padding()
                .frame(minWidth: 150)
                .background(.blue)
                .foregroundStyle(.white)
                .font(.system(size: 80))
                .clipShape(.capsule)
                .overlay(Capsule().stroke(.black, lineWidth: 2))
            }
        }
        .alert("Game Over", isPresented: $isGameOver) {
            Button("Restart", action: restartGame)
        } message: {
            Text("Your final score is \(score).")
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
        if result(for: userMove, against: moves[currentChoice], shouldWin: shouldPlayerWin) {
            score += 1
        } else {
            score -= 1
        }
        validateGameState()
    }

    private func validateGameState() {
        checkIfGameIsOver()
        guard !isGameOver else { return }
        currentTurn += 1
        shuffleMoves()
    }

    private func shuffleMoves() {
        currentChoice = Int.random(in: 0 ..< 2)
        shouldPlayerWin = Bool.random()
    }

    private func checkIfGameIsOver() {
        isGameOver = !(currentTurn < 9)
    }

    private func restartGame() {
        score = 0
        currentTurn = 0
        shuffleMoves()
    }
}

#Preview {
    ContentView()
}

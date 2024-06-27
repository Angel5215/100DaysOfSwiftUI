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
        ZStack {
            BackgroundGradient()

            VStack(spacing: 16) {
                Text("Score: \(score)")
                    .font(.largeTitle.bold())
                    .foregroundStyle(.white)

                VStack {
                    Text("You should ") +
                        Text(shouldPlayerWinText.uppercased())
                        .font(.title2.bold())
                    Text(" against ") +
                        Text(currentChoiceText.uppercased())
                        .font(.title2.bold())
                }
                .foregroundStyle(.white)
                .font(.headline)

                VStack {
                    Text("Select your move:")
                        .foregroundStyle(.secondary)
                        .font(.headline)

                    SelectionButton(title: "🪨", subtitle: "Rock") {
                        updateScore(userMove: "Rock")
                    }
                    SelectionButton(title: "📃", subtitle: "Paper") {
                        updateScore(userMove: "Paper")
                    }
                    SelectionButton(title: "✂️", subtitle: "Scissors") {
                        updateScore(userMove: "Scissors")
                    }
                }
                .frame(maxWidth: .infinity)
                .padding(.vertical, 20)
                .background(.regularMaterial)
                .clipShape(.rect(cornerRadius: 20))
            }
            .padding()
            .alert("Game Over", isPresented: $isGameOver) {
                Button("Restart", action: restartGame)
            } message: {
                Text("Your final score is \(score).")
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

struct BackgroundGradient: View {
    var body: some View {
        LinearGradient(
            stops: [
                Gradient.Stop(
                    color: Color(red: 38 / 255, green: 0, blue: 0),
                    location: 0.1
                ),
                Gradient.Stop(
                    color: Color(red: 36 / 255, green: 1 / 255, blue: 63 / 255),
                    location: 0.3
                ),
                Gradient.Stop(
                    color: Color(red: 38 / 255, green: 0, blue: 0),
                    location: 0.8
                ),
            ],
            startPoint: .top,
            endPoint: .bottom
        )
        .ignoresSafeArea()
    }
}

struct SelectionButton: View {
    let title: String
    let subtitle: String
    let action: () -> Void

    var body: some View {
        Button(action: action) {
            VStack(spacing: 0) {
                Text(title)
                    .foregroundStyle(.white)
                    .font(.system(size: 80))
                Text(subtitle)
                    .foregroundStyle(.white)
                    .font(.system(size: 20).bold().smallCaps())
            }
            .padding()
            .frame(minWidth: 200)
            .background(
                LinearGradient(
                    stops: [
                        Gradient.Stop(color: .blue.opacity(0.9), location: 0),
                        Gradient.Stop(color: .purple.opacity(0.9), location: 0),
                        Gradient.Stop(color: .blue.opacity(0.9), location: 0.4),
                        Gradient.Stop(color: .red.opacity(0.9), location: 1),
                        Gradient.Stop(color: .blue.opacity(0.9), location: 1),
                    ],
                    startPoint: .topLeading,
                    endPoint: .bottomTrailing
                )
            )
        }
        .clipShape(.capsule)
        .overlay(Capsule().stroke(.black, lineWidth: 2))
    }
}

#Preview {
    ContentView()
}

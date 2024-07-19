//
// ContentView.swift
// Last modified by 'Ángel Vázquez' in 2024.
//

import SwiftUI

// MARK: - ContentView

struct ContentView: View {
    @State private var countries = [
        "Estonia",
        "France",
        "Germany",
        "Ireland",
        "Italy",
        "Nigeria",
        "Poland",
        "Spain",
        "UK",
        "Ukraine",
        "US",
    ].shuffled()

    @State private var correctAnswer = Int.random(in: 0 ... 2)
    @State private var showingScore = false
    @State private var scoreTitle = ""
    @State private var score = 0

    @State private var currentQuestion = 0
    @State private var isGameOver = false

    @State private var rotationAmount = 0.0
    @State private var opacity = 1.0
    @State private var tappedFlag = 0

    var body: some View {
        ZStack {
            RadialGradient(
                stops: [
                    Gradient.Stop(
                        color: Color(red: 0.1, green: 0.2, blue: 0.45),
                        location: 0.3
                    ),
                    Gradient.Stop(
                        color: Color(red: 0.76, green: 0.15, blue: 0.26),
                        location: 0.3
                    ),
                ],
                center: .top,
                startRadius: 200,
                endRadius: 700
            )
            .ignoresSafeArea()

            VStack {
                VStack {
                    Spacer()
                    Text("Guess the Flag")
                        .font(.largeTitle.weight(.bold))
                        .foregroundStyle(.white)
                    Spacer()
                    Spacer()
                    Text("Score: \(score)")
                        .foregroundStyle(.white)
                        .font(.title.bold())
                    Spacer()
                }

                VStack(spacing: 15) {
                    VStack {
                        Text("Tap the flag of")
                            .font(.subheadline.weight(.heavy))
                            .foregroundStyle(.secondary)
                        Text(countries[correctAnswer])
                            .font(.largeTitle.weight(.semibold))
                    }

                    ForEach(0 ..< 3) { number in
                        Button {
                            flagTapped(number)
                        } label: {
                            FlagImage(name: countries[number])
                                .rotation3DEffect(
                                    .degrees(tappedFlag == number ? rotationAmount : 0),
                                    axis: (x: 0, y: 1, z: 0)
                                )
                                .opacity(tappedFlag != number ? opacity : 1)
                        }
                    }
                }
                .frame(maxWidth: .infinity)
                .padding(.vertical, 20)
                .background(.regularMaterial)
                .clipShape(.rect(cornerRadius: 20))
            }
            .padding()
        }
        .alert(scoreTitle, isPresented: $showingScore) {
            Button("Continue", action: askQuestion)
        } message: {
            Text("Your score is \(score)")
        }
        .alert("Game Over", isPresented: $isGameOver) {
            Button("Restart", action: restartGame)
        } message: {
            Text("Your final score is: \(score)")
        }
    }

    func flagTapped(_ number: Int) {
        if number == correctAnswer {
            scoreTitle = "Correct"
            score += 5
        } else {
            scoreTitle = "Wrong! That's the flag of \(countries[number])"
            score -= 5
        }

        withAnimation(.bouncy(duration: 0.75)) {
            tappedFlag = number
            rotationAmount += 360
            opacity = 0.25
        }

        showingScore = true
        currentQuestion += 1
    }

    func askQuestion() {
        checkIfGameIsOver()
        restoreAnimationState()
        guard !isGameOver else { return }
        shuffleQuestions()
    }

    func shuffleQuestions() {
        countries.shuffle()
        correctAnswer = Int.random(in: 0 ... 2)
    }

    func restartGame() {
        currentQuestion = 0
        score = 0
        shuffleQuestions()
    }

    func checkIfGameIsOver() {
        if currentQuestion > 7 {
            isGameOver = true
        }
    }

    func restoreAnimationState() {
        tappedFlag = -1
        rotationAmount = 0
        opacity = 1
    }
}

// MARK: - FlagImage

struct FlagImage: View {
    let name: String

    var body: some View {
        Image(name)
            .clipShape(.capsule)
            .shadow(radius: 5)
    }
}

#Preview {
    ContentView()
}

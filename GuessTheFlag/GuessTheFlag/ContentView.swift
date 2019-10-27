//
//  ContentView.swift
//  GuessTheFlag
//
//  Created by Angel Vázquez on 13/10/19.
//  Copyright © 2019 Ángel Vázquez. All rights reserved.
//

import SwiftUI

struct ContentView: View {
    
    // MARK: - Game properties
    @State private var correctAnswer = Int.random(in: 0...2)
    @State private var score = 0
    @State private var countries = ["Estonia", "France", "Germany", "Ireland", "Italy", "Nigeria", "Poland", "Russia", "Spain", "UK", "US"]
    
    // MARK: - Alert properties
    @State private var showingScore = false
    @State private var scoreTitle = ""
    @State private var scoreMessage = ""
    
    // MARK: - Colors
    private let backgroundColors = [
        Color(.systemPurple),
        Color(.systemRed),
        Color(.systemPink),
        Color(.systemPurple),
    ]
    
    // MARK: - Animation properties
    @State private var rotationAmounts = [0.0, 0.0, 0.0]
    @State private var opacityAmounts = [1.0, 1.0, 1.0]
    @State private var wrongRotations = [0.0, 0.0, 0.0]
    @State private var wrongScalings: [CGFloat] = [1, 1, 1]
    
    var body: some View {
        ZStack {
            LinearGradient(gradient: Gradient(colors: backgroundColors), startPoint: .topLeading, endPoint: .bottomTrailing)
                .edgesIgnoringSafeArea(.all)
                    
            VStack(spacing: 30) {
                VStack {
                    Text("Tap the flag of")
                    Text(countries[correctAnswer])
                        .font(.largeTitle)
                        .fontWeight(.black)
                }
                
                ForEach(0 ..< 3) { number in
                    Button(action: {
                        self.flagTapped(number)
                        self.rotationAmounts = [0, 0, 0]
                    }, label: {
                        Image(self.countries[number])
                            .renderingMode(.original)
                            .clipShape(Capsule())
                            .overlay(Capsule().stroke(Color.black, lineWidth: 1))
                            .shadow(color: .black, radius: 2)
                    })
                    .rotation3DEffect(.degrees(self.rotationAmounts[number]), axis: (0, 1, 0))
                    .opacity(self.opacityAmounts[number])
                    .rotation3DEffect(.degrees(self.wrongRotations[number]), axis: (1, 1, 1))
                    .scaleEffect(self.wrongScalings[number], anchor: .center)
                }
                
                VStack {
                    Text("Score")
                    Text("\(score)")
                        .font(.largeTitle)
                        .fontWeight(.black)
                }
                
                Spacer()
            }
        }
        .alert(isPresented: $showingScore) {
            Alert(title: Text(scoreTitle), message: Text(scoreMessage), dismissButton: .default(Text("Continue")) {
                self.askQuestion()
            })
        }
    }
    
    func flagTapped(_ number: Int) {
        if number == correctAnswer {
            score += 1
            scoreTitle = "Correct 😃"
            scoreMessage = "Great! Your score is \(score)."
            
            withAnimation {
                rotationAmounts[number] += 360
                for index in otherButtonIndexes(for: number) {
                    opacityAmounts[index] = 0.25
                }
            }
        } else {
            score -= 1
            scoreTitle = "Incorrect ☹️"
            scoreMessage = "Wrong! That's the flag of \(countries[number]). Your score is \(score)."
            
            withAnimation(.easeInOut) {
                wrongRotations[number] -= 90
                wrongScalings[number] = 0
            }
        }
        
        showingScore = true
    }
    
    func askQuestion() {
        // Restart animation values
        rotationAmounts = [0, 0, 0]
        opacityAmounts = [1, 1, 1]
        wrongRotations = [0, 0, 0]
        wrongScalings = [1, 1, 1]
        
        // Select a current flag for this round
        countries.shuffle()
        correctAnswer = Int.random(in: 0...2)
    }
    
    private func otherButtonIndexes(for number: Int) -> [Int] {
        switch number {
        case 0:
            return [1, 2]
        case 1:
            return [0, 2]
        default:
            return [0, 1]
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}

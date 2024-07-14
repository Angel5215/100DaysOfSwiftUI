//
// ContentView.swift
// Last modified by 'Ángel Vázquez' in 2024.
//

import SwiftUI

struct ContentView: View {
    @State private var usedWords = [String]()
    @State private var rootWord = ""
    @State private var newWord = ""

    @State private var errorTitle = ""
    @State private var errorMessage = ""
    @State private var showingError = false

    @State private var score = 0

    var body: some View {
        NavigationStack {
            ZStack(alignment: .bottomTrailing) {
                List {
                    Section {
                        TextField("Enter your word", text: $newWord)
                            .textInputAutocapitalization(.never)
                    }

                    Section {
                        ForEach(usedWords, id: \.self) { word in
                            HStack {
                                Image(systemName: "\(word.count).circle")
                                Text(word)
                            }
                        }
                    }
                }
                .navigationTitle(rootWord)
                .onSubmit(addNewWord)
                .onAppear(perform: startGame)
                .alert(errorTitle, isPresented: $showingError) {} message: {
                    Text(errorMessage)
                }
                .toolbar {
                    Button("Restart", action: startGame)
                }

                HStack {
                    Spacer()
                    Text("Score: \(score)")
                        .font(.headline.weight(.bold).smallCaps().monospacedDigit())
                }
                .padding()
            }
        }
    }

    func addNewWord() {
        let answer = newWord.lowercased().trimmingCharacters(in: .whitespacesAndNewlines)

        guard answer.count > 0 else { return }

        guard isOriginal(word: answer) else {
            return wordError(title: "Word used already", message: "Be more original")
        }

        guard isPossible(word: answer) else {
            return wordError(title: "Word not possible", message: "You can't spell that word from '\(rootWord)'")
        }

        guard isAllowed(word: answer) else {
            return wordError(title: "Word not allowed", message: "Word is less than 3 characters long or is the same as the start word")
        }

        guard isReal(word: answer) else {
            return wordError(title: "Word not recognized", message: "You can't just make them up, you know!")
        }

        withAnimation {
            usedWords.insert(answer, at: 0)
            score += usedWords.count + answer.count
        }

        newWord = ""
    }

    func startGame() {
        withAnimation {
            newWord = ""
            usedWords.removeAll()
            score = 0
        }

        if let startWordsURL = Bundle.main.url(forResource: "start", withExtension: "txt") {
            if let startWords = try? String(contentsOf: startWordsURL) {
                let allWords = startWords.components(separatedBy: "\n")
                rootWord = allWords.randomElement() ?? "silkworm"
                return
            }
        }

        fatalError("Could not load start.txt from bundle.")
    }

    func isOriginal(word: String) -> Bool {
        !usedWords.contains(word)
    }

    func isPossible(word: String) -> Bool {
        var tempWord = rootWord

        for letter in word {
            if let pos = tempWord.firstIndex(of: letter) {
                tempWord.remove(at: pos)
            } else {
                return false
            }
        }

        return true
    }

    func isReal(word: String) -> Bool {
        let checker = UITextChecker()
        let range = NSRange(location: 0, length: word.utf16.count)
        let misspelledRange = checker.rangeOfMisspelledWord(
            in: word,
            range: range,
            startingAt: 0,
            wrap: false,
            language: "en"
        )

        return misspelledRange.location == NSNotFound
    }

    func wordError(title: String, message: String) {
        errorTitle = title
        errorMessage = message
        showingError = true
    }

    func isAllowed(word: String) -> Bool {
        word.count > 2 && word != rootWord
    }
}

#Preview {
    ContentView()
}

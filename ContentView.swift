import SwiftUI

struct ContentView: View {
    @State private var words = [
        "apple", "house", "tiger", "beach", "music",
        "planet", "garden", "orange", "school", "bottle"
    ]

    @State private var currentWord = ""
    @State private var scrambledWord = ""
    @State private var userGuess = ""
    @State private var message = "Welcome to WordGame!"
    @State private var score = 0

    var body: some View {
        VStack(spacing: 20) {
            Text("WordGame")
                .font(.largeTitle)
                .bold()

            Text("Unscramble this word:")
                .font(.headline)

            Text(scrambledWord)
                .font(.title)
                .padding()

            TextField("Enter your guess", text: $userGuess)
                .textFieldStyle(.roundedBorder)
                .padding(.horizontal)

            Button("Submit Guess") {
                checkGuess()
            }
            .buttonStyle(.borderedProminent)

            Button("Restart Game") {
                restartGame()
            }
            .buttonStyle(.bordered)

            Text("Score: \(score)")
                .font(.title3)

            Text(message)
                .padding()

            Spacer()
        }
        .padding()
        .onAppear {
            startNewRound()
        }
    }

    func startNewRound() {
        currentWord = words.randomElement() ?? "apple"
        scrambledWord = String(currentWord.shuffled())
        userGuess = ""
        message = "Guess the word!"
    }

    func checkGuess() {
        let cleanedGuess = userGuess.trimmingCharacters(in: .whitespacesAndNewlines)

        if cleanedGuess.isEmpty {
            message = "Please enter a word."
        } else if cleanedGuess.lowercased() == currentWord.lowercased() {
            score += 1
            message = "Correct!"
            startNewRound()
        } else {
            message = "Try again."
        }
    }

    func restartGame() {
        score = 0
        startNewRound()
        message = "Game restarted."
    }
}

#Preview {
    ContentView()
}

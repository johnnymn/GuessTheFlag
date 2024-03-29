import SwiftUI

struct ContentView: View {
  @State private var countries = [
    "Estonia", "France", "Germany",
    "Ireland", "Italy", "Nigeria",
    "Poland", "Russia", "Spain",
    "UK", "US"
  ].shuffled()

  @State private var correctAnswer = Int.random(in: 0...2)

  // Tracks the state of the score alert.
  @State private var showingScore = false
  @State private var scoreTitle = ""

  // Tracks the score.
  @State private var score = 0

  var body: some View {
    // Use a ZStack so that we can
    // put a background.
    ZStack {
      Color.blue.ignoresSafeArea(.all)

      // Space the views inside of this
      // stack a bit.
      VStack(spacing: 30) {
        VStack {
          Spacer()
          Text("Tap the flag of").foregroundColor(.white)
          Text(countries[correctAnswer])
                  .foregroundColor(.white)
                  .font(.largeTitle)
                  .fontWeight(.black)
        }

        // Display the flags.
        ForEach(0..<3) { index in
          Button(action: { self.checkAnswer(index) }, label: {
            Image(countries[index])
                    // Use rendering mode original so that
                    // SwiftUI doesn't recolor them as a button.
                    .renderingMode(.original)
                    .clipShape(RoundedRectangle(
                            cornerRadius: 25,
                            style: .continuous))
                    .overlay(RoundedRectangle(
                            cornerRadius: 25,
                            style: .continuous)
                            .stroke(Color.black, lineWidth: 1))
                    .shadow(color: .black, radius: 2)
          })
        }

        // Show the Score
        Section(header: Text("Your score is")
                .fontWeight(.black)
                .font(.title2)) {
          Text("\(score)")
                  .fontWeight(.black)
                  .font(.title)
        }

        // Push things up.
        Spacer()
      }
    }.alert(isPresented: $showingScore) {
      Alert(
              title: Text(scoreTitle),
              message: Text("Your score is \(score)"),
              dismissButton: .default(Text("Continue")) {
                shuffle()
              })
    }
  }

  // Checks if the tapped flag is the correct answer
  // and if it is sets showingScore to true so the alert
  // triggers and increments the score.
  func checkAnswer(_ index: Int) {
    if index == correctAnswer {
      scoreTitle = "Correct"
      score += 1
    } else {
      scoreTitle = "Wrong"
    }

    showingScore = true
  }

  // Shuffles the countries array and
  // selects a new correct answer.
  func shuffle() {
    countries.shuffle()
    correctAnswer = Int.random(in: 0...2)
  }
}

struct ContentView_Previews: PreviewProvider {
  static var previews: some View {
    ContentView()
  }
}

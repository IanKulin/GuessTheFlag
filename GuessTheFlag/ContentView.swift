//
//  ContentView.swift
//  GuessTheFlag
//
//  Created by Ian Bailey on 22/8/2022.
//

import SwiftUI

struct ContentView: View {
    
    @State private var countries = ["Estonia", "France", "Germany", "Ireland", "Italy", "Nigeria", "Poland", "Russia", "Spain", "UK", "US"].shuffled()
    
    @State private var correctAnswer = Int.random(in: 0...2)
    
    @State private var showingScore = false
    @State private var showingReset = false
    @State private var resetScores = false
    
    @State private var scoreTitle = ""
    @State private var messageText = ""
    @State private var correctScore = 0
    @State private var incorrectScore = 0
    
    var body: some View {
        ZStack {
            LinearGradient(gradient: Gradient(
                colors: [Color(red: 0.1, green: 0.2, blue: 0.45),
                          Color(red: 0.76, green: 0.15, blue: 0.26)]),
                    startPoint: .top, endPoint: .bottom)
            .ignoresSafeArea()
            
            VStack {
                Spacer()
                Text("Guess the Flag")
                    .font(.largeTitle.weight(.bold))
                    .foregroundColor(.white)
            
                VStack(spacing: 15) {
                    VStack {
                        Text("Tap the flag of")
                            .foregroundStyle(.secondary)
                            .font(.subheadline.weight(.heavy))
                        
                        Text(countries[correctAnswer])
                            .font(.largeTitle.weight(.semibold))
                    }
                    
                    ForEach(0..<3) { number in
                        Button {
                            // flag was tapped
                            flagTapped(number)
                        } label: {
                            Image(countries[number])
                                .renderingMode(.original)
                                .shadow(radius: 5)
                        }
                    }
                }
                .frame(maxWidth: .infinity)
                .padding(.vertical, 20)
                .background(.regularMaterial)
                .clipShape(RoundedRectangle(cornerRadius: 20))
                
                Spacer()
                Spacer()
                Text("Guess \(correctScore+incorrectScore)/8")
                    .foregroundColor(.white)
                Text("Score: \(correctScore)")
                    .foregroundColor(.white)
                    .font(.title.bold())
                Spacer()
            }
            .padding()
        }
        .alert(scoreTitle, isPresented: $showingScore) {
            Button("Continue", action: askQuestion)
        } message: {
            Text(messageText+"Your score is \(correctScore)")
        }
        .alert(scoreTitle, isPresented: $showingReset) {
            Button("Restart", action: askQuestion)
        } message: {
            Text(messageText+"Your score was \(correctScore) out of 8")
        }

    }
    
    func flagTapped(_ number: Int) {
        if number == correctAnswer {
            scoreTitle = "Correct"
            messageText = ""
            correctScore += 1
        } else {
            scoreTitle = "Wrong"
            messageText = "That was \(countries[number]) \n"
            incorrectScore += 1
        }
        
        if correctScore+incorrectScore == 8 {
            // game over
            resetScores = true
            showingReset = true
        }
        else {
            showingScore = true
        }
    }
    
    func askQuestion() {
        if resetScores {
            correctScore = 0
            incorrectScore = 0
            resetScores.toggle()
        }
        countries.shuffle()
        correctAnswer = Int.random(in: 0...2)
    }
}





struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}

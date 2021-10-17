//
//  ContentView.swift
//  GuessTheFlag
//
//  Created by Michael Gresham on 16/10/2021.
//

import SwiftUI

struct ContentView: View {
    @State private var countries = ["Estonia", "France", "Germany", "Ireland", "Italy", "Nigeria", "Poland", "Russia", "Spain", "UK", "US"].shuffled()
    @State private var correctAnswer = Int.random(in: 0...2)
    @State private var score = 0
    @State private var record = 0
    
    @State private var showingScore = false
    @State private var scoreTitle = ""
    @State private var scoreMessage = ""


    
    var body: some View {
        
        ZStack {
            LinearGradient(colors: [.blue, .black], startPoint: .top, endPoint: .bottom).ignoresSafeArea()
            VStack(spacing: 30) {
                VStack {
                    Text("Tap the flag of")
                        .foregroundColor(.white)
                    Text(countries[correctAnswer])
                        .foregroundColor(.white)
                        .font(.largeTitle)
                        .fontWeight(.black)
                }
                ForEach(0 ..< 3) { number in
                    Button(action: {
                        self.flagTapped(number)
                    }) {
                        Image(self.countries[number]).renderingMode(.original)
                            .clipShape(Capsule())
                            .overlay(Capsule().stroke(Color.black, lineWidth: 1))
                            .shadow(color: .black, radius: 2)
                    }
                }
                VStack {
                    Text("Your Score is \(score)")
                        .foregroundColor(.white)
                        .fontWeight(.black)
                        .font(.title2)
                    
                    Text("Your Record is \(record)")
                        .foregroundColor(.white)
                }
         
                Spacer()
            }
        }
        .alert(isPresented: $showingScore) {
            Alert(title: Text(scoreTitle), message: Text(scoreMessage), dismissButton: .default(Text("Contine")) {
                self.askQuestion()
            })
        }
    }
    func flagTapped(_ number: Int) {
        if number == correctAnswer {
            score += 1
            if score > record { record = score }
            scoreTitle = "Correct"
            scoreMessage = "Your score is \(score)"
        } else {
            score = 0
            scoreTitle = "False"
            scoreMessage = "That's the flag of \(countries[number])"
        }
        showingScore = true
    }
    
    func askQuestion() {
        countries.shuffle()
        correctAnswer = Int.random(in: 0...2)
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}

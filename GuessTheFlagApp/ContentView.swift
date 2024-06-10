//
//  ContentView.swift
//  GuessTheFlagApp
//
//  Created by Batuhan Arda on 10.06.2024.
//

import SwiftUI

struct ContentView: View {
    @State private var countries = ["Estonia", "France", "Germany", "Ireland", "Italy", "Nigeria", "Poland", "Spain", "UK", "US"].shuffled()
    // with shuffled we mixed list items
    @State private var correctAnswer = Int.random(in: 0...2) // we selected indeks 0,1,2 by random
    @State private var showingScore = false
    @State private var scoreTitle = ""
    @State private var yourScore = 0

    var body: some View {
        ZStack {
            RadialGradient(stops:[
                .init(color: Color(red: 0.4, green: 0.5, blue: 0.5), location: 0.3),
                .init(color: Color(red: 0.90, green: 0.15, blue: 0.2), location:0.3)],
                 center: .top, startRadius: 200, endRadius: 700)
            .ignoresSafeArea() // we filled all of the screen
            VStack{
                Spacer()
                Text("Guess the Flag")
                    .font(.largeTitle.bold()) // weight and font size
                    .foregroundStyle(.white) // font color
                VStack(spacing:20){
                    
                    VStack{
                        Text("Tap the Flag")
                            .foregroundStyle(.secondary) // text color actually that grey
                            .font(.subheadline.weight(.heavy))
                        Text(countries[correctAnswer]) // we showed which country selected in the list which is index
                            .font(.largeTitle.weight(.semibold))
                    }
                    ForEach(0..<3) { number in
                        Button{
                            flagTapped(number)
                        }label:{
                            Image(countries[number])
                                .clipShape(.capsule)
                                .shadow(radius: 10)
                        }}
                } .frame(maxWidth:.infinity) // regularmaterial frame
                    .padding(.vertical,20) // regularmaterial padding
                    .background(.regularMaterial)
                    .clipShape(.rect(cornerRadius: 20))
                Spacer()
                Spacer()
                Text("Score: \(yourScore)")
                    .foregroundStyle(.white)
                    .font(.title.bold())
                Spacer()

            }
            .padding()
            
            
        }
        .alert(scoreTitle, isPresented: $showingScore){
            Button("Continue", action:askQuestion)
        }message: {
            Text("Your score is \(yourScore)")
        }
        
        
       
    }
    func flagTapped(_ number:Int){
        if number == correctAnswer{
            scoreTitle = "Correct"
            yourScore += 1
        
        }else {
            scoreTitle = "Wrong"
            yourScore -= 1
        }
        showingScore = true
    }
    func askQuestion() {
           countries.shuffle() // again mix
           correctAnswer = Int.random(in: 0...2)
       }
}

#Preview {
    ContentView()
}

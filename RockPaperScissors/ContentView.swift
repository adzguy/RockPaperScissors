//
//  ContentView.swift
//  RockPaperScissors
//
//  Created by Davron on 11/26/19.
//  Copyright © 2019 Davron. All rights reserved.
//

import SwiftUI

struct ContentView: View {
    
    @State private var shouldWin = Bool.random()
    @State private var currentMove = Int.random(in: 0...2)
    @State private var showigScore = false
    @State private var questionCounter = 0
    @State private var score = 0
    
    let moves = ["Rock", "Paper", "Scissors"]
    
    var body: some View {
        ZStack {
            LinearGradient(gradient: Gradient(colors: [.white, .gray]), startPoint: .top, endPoint: .bottom)
            
            VStack(spacing: 80) {
                VStack(spacing: 20) {
                    Text("Train Your Brain!")
                        .font(.headline)
                        .fontWeight(.heavy)
                        .padding(50)
                    Image(moves[currentMove])
                        .cornerRadius(30)
                    Text("You need to ")+Text(shouldWin ? "WIN" : "LOSE")
                        .foregroundColor(shouldWin == true ? .green : .red).fontWeight(.heavy)+Text(" this turn")
        
                }

                HStack(spacing: 30) {
                    ForEach(0..<moves.count) {number in
                        Button(action: {
                            //once tapped do something
                            self.tapped(number: number)
                            self.askQuestion()
                        }) {
                            Image(self.moves[number])
                                .renderingMode(.original)
                                .cornerRadius(30)
                                
                        }
                    }
                }
                Text("\(questionCounter)/10")
                Spacer()
            }

        }.edgesIgnoringSafeArea(.all)
        .alert(isPresented: $showigScore) {
            Alert(title: Text("Game Over!"), message: Text("Your score is \(score) out of 10 questions"), dismissButton: .default(Text("OK")) {
                self.questionCounter = 0; self.score = 0
                })
        }
    }
    
    func tapped(number: Int) {
    
        if (number == 1 && currentMove == 0) || (number == 2 && currentMove == 1) || (number == 0 && currentMove == 2) && shouldWin {
            score += 1
        }
        else if (number == 0 && currentMove == 1) || (number == 1 && currentMove == 2) || (number == 2 && currentMove == 0) && shouldWin == false {
            score += 1
        }
        else {
            score += 0
        }
        questionCounter += 1
        
        if questionCounter == 10 {
            showigScore = true
            return
        }
    }
    
    func askQuestion() {
        shouldWin = Bool.random()
        currentMove = Int.random(in: 0...2)
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}

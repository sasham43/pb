//
//  scoreView.swift
//  pb
//
//  Created by Sasha Kramer on 3/27/24.
//

import SwiftUI

import ConfettiSwiftUI

struct scoreView: View {
    
    @EnvironmentObject var scoreData : ScoreData
    
    @State private var status: String = ""
    @State private var isGameInProgress: Bool = true
    @State private var isShowingAlert: Bool = false
    @State private var pickleScore: String = "0-0-2"
    @State private var isFirstServe: Bool = true
    
    @State private var showConfetti = 0
    
    func resetGame(){
        scoreData.homeScore = 0
        scoreData.awayScore = 0
        status = ""
        scoreData.serve = 1
        isGameInProgress = true
        isFirstServe = true
    }
    
    func updatePickleScore(){
        if(isFirstServe == true){
            pickleScore = "\(scoreData.homeScore)-\(scoreData.awayScore)-Start"
        } else if(scoreData.serve < 2){
            // home serving
            let serveNum = scoreData.serve +  1
            pickleScore = "\(scoreData.homeScore)-\(scoreData.awayScore)-\(serveNum)"
        } else {
            // away serving
            let serveNum = scoreData.serve == 2 ? 1 : 2
            pickleScore = "\(scoreData.awayScore)-\(scoreData.homeScore)-\(serveNum)"
        }
    }
    
    func checkIfGameOver(){
        if(scoreData.homeScore >= 11 && scoreData.homeScore - scoreData.awayScore >= 2) {
            print("Home wins")
            status = "Home wins"
            isGameInProgress = false
            showConfetti += 1
        }
        if(scoreData.awayScore >= 11 && scoreData.awayScore - scoreData.homeScore >= 2) {
            print("Away wins")
            status = "Away wins"
            isGameInProgress = false
            showConfetti += 1
        }
//        print("game checked")
    }
    
    func handleServe(){
        if (scoreData.serve != 3){
            scoreData.serve += 1
        } else {
            scoreData.serve = 0
        }
        WatchConnector.shared.sendDataToWatch(["serve" : scoreData.serve])
        
        if(isFirstServe == true && scoreData.serve > 1){
            isFirstServe = false
        }
    }
    
    
    var body: some View {
        VStack {
//            Text("Score")
            Text("\(status)")
                .frame(height: 50)
                .confettiCannon(counter: $showConfetti, num: 100, openingAngle: Angle.degrees(180), closingAngle: Angle.degrees(0))
            GeometryReader { geometry in
                VStack {
                    HStack(spacing: 50) {
                        VStack {
                            Score(side: "Home", score: $scoreData.homeScore)
                            ScoreButtons(side: "home", isGameInProgress: $isGameInProgress)
                                .environmentObject(scoreData)

                            HomeServeIndicators(serve: $scoreData.serve)
                        }
                        
                        VStack {
                            Score(side: "Away", score: $scoreData.awayScore)
                            ScoreButtons(side: "away", isGameInProgress: $isGameInProgress)
                                .environmentObject(scoreData)

                            AwayServeIndicators(serve: $scoreData.serve)
                        }
                    }
                    .frame(minWidth: geometry.size.width)
                    Spacer()
                    
                    VStack {
                        Button("Next serve") {
                            handleServe()
                        }
                    }
                    
                    Spacer()
                    
                    
                    // Pickle score
                    VStack {
                        Text("Pickle Score")
                            .font(.system(size: 22))
                            .padding(4)
                        Text("\(pickleScore)")
                            .font(.system(size: 42))
                    }
                    
                    Spacer()
                    
                    VStack {
                        Button("Reset") {
                            isShowingAlert = true
                        }
                        .alert("Are you sure you want to reset the game?", isPresented: $isShowingAlert){
                            Button("Yes"){
                                resetGame()
                            }
                            Button("No", role: .cancel){}
                        }
                    }
                    Spacer()
                }
                
            }
            .onChange(of: [scoreData.homeScore, scoreData.awayScore, scoreData.serve]) {
                checkIfGameOver()
                updatePickleScore()
            }
            Spacer()
        }
        
        .onAppear {
            print("A wild phone appeared!")
            // TODO: Figure out the correct way to initialize these connectors
            WatchConnector.shared.sendDataToWatch(["Handshake" : ""])
            
            updatePickleScore()
        }
    }
}

struct HomeServeIndicators: View {
    @Binding var serve: Int
    
    var body: some View {
        if(serve == 0){
            ServeIndicator(filled: true)
            ServeIndicator(filled: false)
        } else if(serve == 1){
            ServeIndicator(filled: true)
            ServeIndicator(filled: true)
        } else {
            ServeIndicator(filled: false)
            ServeIndicator(filled: false)
        }
    }
}
struct AwayServeIndicators: View {
    @Binding var serve: Int
    
    var body: some View {
        if(serve == 2){
            ServeIndicator(filled: true)
            ServeIndicator(filled: false)
        } else if(serve == 3){
            ServeIndicator(filled: true)
            ServeIndicator(filled: true)
        } else {
            ServeIndicator(filled: false)
            ServeIndicator(filled: false)
        }
    }
}

struct Score: View {
    @State var side: String
    @Binding var score: Int
    
    var body: some View {
        Text("\(score)")
            .font(.system(size: 70))
        Text("\(side)")
    }
}

struct ScoreButtons: View {
    @State var side: String
    @Binding var isGameInProgress: Bool
    @EnvironmentObject var scoreData: ScoreData
    
    
    func handleScore(action: String, side: String){
        // elegance personified
        if(action == "+" && side == "home"){
            scoreData.homeScore += 1
        } else if (action == "+" && side == "away"){
            scoreData.awayScore += 1
        } else if (action == "-" && side == "home"){
            if(scoreData.homeScore != 0){
                scoreData.homeScore -= 1
            }
        } else if (action == "-" && side == "away"){
            if(scoreData.awayScore != 0){
                scoreData.awayScore -= 1
            }
        }
        WatchConnector.shared.sendDataToWatch(["home" : scoreData.homeScore])
        WatchConnector.shared.sendDataToWatch(["away" : scoreData.awayScore])
    }
    
    var body: some View {
        Button("+") {
            handleScore(action: "+", side: side)
        }
        .font(.system(size: 50))
        .disabled(!isGameInProgress)
        Button("-") {
                handleScore(action: "-", side: side)
        }
        .font(.system(size: 50))
        .disabled(!isGameInProgress)
    }
}

#Preview {
    scoreView()
}

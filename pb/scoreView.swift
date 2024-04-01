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
    
//    let purpleColor = Color(red: 100 / 250, green: 49 / 250, blue: 97 / 250)
//    let backgroundColor = Color(red: 74 / 255, green: 74 / 255, blue: 74 / 255)
    let backgroundColor = Color(red: 24 / 255, green: 24 / 255, blue: 24 / 255)
    let foregroundColor = Color.white
    let homeColor = Color(red: 41 / 255, green: 77 / 255, blue: 74 / 255)
    let awayColor = Color(red: 100 / 255, green: 49 / 255, blue: 97 / 255)
    let redColor = Color(red: 142 / 255, green: 62 / 255, blue: 62 / 255)
    let yellowColor = Color(red: 255 / 255, green: 191 / 255, blue: 70 / 255)
    //    let awayColor = Color(red: 142 / 250, green: 62 / 250, blue: 62 / 250)
    
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
                .confettiCannon(counter: $showConfetti, num: 100, colors: scoreData.serve > 1 ? [awayColor, .white] : [homeColor, .white], openingAngle: Angle.degrees(180), closingAngle: Angle.degrees(0))
            GeometryReader { geometry in
                VStack {
                    // Scores
                    HStack(spacing: 5) {
                        HStack {
                            Spacer()
                            VStack {
                                ScoreButtons(side: "home", isGameInProgress: $isGameInProgress)
                            }
                            Spacer()
                            VStack {
                                ScoreDisplay(side: "Home", score: $scoreData.homeScore)
                            }
                        }
                        
                        Text("-")
                        
                        HStack {
                            VStack {
                                ScoreDisplay(side: "Away", score: $scoreData.awayScore)
                            }
                            Spacer()
                            VStack {
                                ScoreButtons(side: "away", isGameInProgress: $isGameInProgress)
                            }
                            Spacer()
                        }
                    }
                    .frame(minWidth: geometry.size.width)
                    
                    Spacer()
                    
                    // Serve button
                    HStack {
                        HomeServeIndicators(serve: $scoreData.serve)
                        Spacer()
                        VStack {
                            Button("Next serve") {
                                handleServe()
                            }
                            .frame(width: 100, height: 50)
                            .background(yellowColor)
                            .foregroundColor(.black)
                            .clipShape(RoundedRectangle(cornerRadius: 8))
                        }
                        Spacer()
                        AwayServeIndicators(serve: $scoreData.serve)
                    }
                    .frame(height: 50)
                    .padding(15)
                    
                    
                    Spacer()
                    
                    // Pickle score
                    VStack {
                        Text("Pickle Score")
                            .font(.system(size: 22))
                            .padding(4)
                        PickleScore()
                    }
                    
                    Spacer()
                    
                    // Reset button
                    VStack {
                        Button("Reset") {
                            isShowingAlert = true
                        }
                        .frame(width: 100, height: 50)
                        .background(redColor)
                        .clipShape(RoundedRectangle(cornerRadius: 8))
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
        .padding(15)
        .background(backgroundColor)
        .foregroundColor(foregroundColor)
        
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

struct ScoreDisplay: View {
    @State var side: String
    @Binding var score: Int
    
    var body: some View {
        Text("\(score)")
            .font(.system(size: 70))
            .frame(minWidth: 100)
    }
}

struct ScoreButtons: View {
    @State var side: String
    @Binding var isGameInProgress: Bool
    @EnvironmentObject var scoreData: ScoreData
    
    let homeColor = Color(red: 41 / 250, green: 77 / 250, blue: 74 / 250)
    let awayColor = Color(red: 100 / 250, green: 49 / 250, blue: 97 / 250) // purple
//    let awayColor = Color(red: 142 / 250, green: 62 / 250, blue: 62 / 250) // red
    
//    let purpleColor = Color(red: 100 / 250, green: 49 / 250, blue: 97 / 250)
    
    
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
        VStack(spacing: 5){
            Button("+") {
                handleScore(action: "+", side: side)
            }
            .frame(minWidth: 60, maxWidth: 100)
            .frame(height: 100)
            .font(.system(size: 50))
            .disabled(!isGameInProgress)
            .background(side == "home" ? homeColor : awayColor)
            .clipShape(RoundedRectangle(cornerRadius: 8))
            
            Button("-") {
                    handleScore(action: "-", side: side)
            }
            .frame(minWidth: 60, maxWidth: 100)
            .frame(height: 100)
            .font(.system(size: 50))
            .disabled(!isGameInProgress)
            .background(side == "home" ? homeColor : awayColor)
            .clipShape(RoundedRectangle(cornerRadius: 8))
        }
    }
}

struct PickleScore: View {
    @EnvironmentObject var scoreData: ScoreData
    
    let homeColor = Color(red: 41 / 255, green: 77 / 255, blue: 74 / 255)
    let awayColor = Color(red: 100 / 255, green: 49 / 255, blue: 97 / 255)
    let yellowColor = Color(red: 255 / 255, green: 191 / 255, blue: 70 / 255)
    
    var homeScoreText: AttributedString {
        var text = AttributedString(" \(scoreData.homeScore) ")
        text.backgroundColor = homeColor
        text.foregroundColor = .white
        return text
    }
    var awayScoreText: AttributedString {
        var text = AttributedString(" \(scoreData.awayScore) ")
        text.backgroundColor = awayColor
        text.foregroundColor = .white
        return text
    }
    var serveText: AttributedString {
        var serveNumber = 1
        
        if(scoreData.serve == 0 || scoreData.serve == 2){
            serveNumber = 1
        } else if (scoreData.serve == 1 || scoreData.serve == 3){
            serveNumber = 2
        }
        
        var text = AttributedString(" \(serveNumber) ")
        text.backgroundColor = yellowColor
        text.foregroundColor = .black
        
        return text
    }
    
    var body: some View {
        if(scoreData.serve == 0 || scoreData.serve == 1){
            HStack {
                ZStack {
                    Text(homeScoreText)
                }
                .clipShape(RoundedRectangle(cornerRadius: 8))
                Text("-")
                ZStack {
                    Text(awayScoreText)
                }
                .clipShape(RoundedRectangle(cornerRadius: 8))
                Text("-")
                ZStack {
                    Text(serveText)
                }
                .clipShape(RoundedRectangle(cornerRadius: 8))
            }.font(.system(size: 42))
        } else if (scoreData.serve == 2 || scoreData.serve == 3) {
            HStack {
                ZStack {
                    Text(awayScoreText)
                }
                .clipShape(RoundedRectangle(cornerRadius: 8))
                Text("-")
                ZStack {
                    Text(homeScoreText)
                }
                .clipShape(RoundedRectangle(cornerRadius: 8))
                Text("-")
                ZStack {
                    Text(serveText)
                }
                .clipShape(RoundedRectangle(cornerRadius: 8))
            }.font(.system(size: 42))
        }
        
    }
}

#Preview {
    scoreView()
}

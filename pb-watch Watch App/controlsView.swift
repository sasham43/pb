//
//  controlsView.swift
//  pb-watch Watch App
//
//  Created by Sasha Kramer on 3/27/24.
//

import SwiftUI


struct controlsView: View {
    
//    @EnvironmentObject public var homeScore : Int = 0
    @EnvironmentObject var scoreData : ScoreData
//    @State private var awayScore : Int = 0
//    @State private var status : String = ""
//    @State private var serve : Int = 1
    @State private var isGameInProgress : Bool = true
    
    @State private var isShowingAlert : Bool = false
    
    // style
    let backgroundColor = Color(red: 24 / 255, green: 24 / 255, blue: 24 / 255)
    let foregroundColor = Color.white
    let homeColor = Color(red: 41 / 255, green: 77 / 255, blue: 74 / 255)
    let awayColor = Color(red: 100 / 255, green: 49 / 255, blue: 97 / 255)
    let redColor = Color(red: 142 / 255, green: 62 / 255, blue: 62 / 255)
    let yellowColor = Color(red: 255 / 255, green: 191 / 255, blue: 70 / 255)
    

    
    var body: some View {
        VStack {
            HStack {
                VStack {
                    HStack {
                        if(scoreData.serve == 0){
                            ServeIndicator(filled: true)
                            ServeIndicator(filled: false)
                        } else if(scoreData.serve == 1){
                            ServeIndicator(filled: true)
                            ServeIndicator(filled: true)
                        } else {
                            ServeIndicator(filled: false)
                            ServeIndicator(filled: false)
                        }
                    }
                    Text("Home: \(scoreData.homeScore)")
                    Button("+") {
                        print("watch +")
                        scoreData.homeScore += 1
                        PhoneConnector.shared.sendDataToPhone(["home" : scoreData.homeScore])
                    }
                    .buttonStyle(PlainButtonStyle())
                    .padding(8)
                    .frame(minWidth: 95)
                    .font(.system(size: 32))
                    .background(homeColor)
                    .clipShape(RoundedRectangle(cornerRadius: 8))
                    
//                    .tint(homeColor)
//                    .buttonStyle(Bor)
                    
                    Button("-") {
                        print("-")
                        if(scoreData.homeScore != 0){
                            scoreData.homeScore -= 1
                            PhoneConnector.shared.sendDataToPhone(["home" : scoreData.homeScore])
                        }
                        
                    }
                    .buttonStyle(PlainButtonStyle())
                    .padding(8)
                    .frame(minWidth: 95)
                    .font(.system(size: 32))
                    .background(homeColor)
                    .clipShape(RoundedRectangle(cornerRadius: 8))
                }
                VStack {
                    HStack {
                        if(scoreData.serve == 2){
                            ServeIndicator(filled: true)
                            ServeIndicator(filled: false)
                        } else if (scoreData.serve == 3){
                            ServeIndicator(filled: true)
                            ServeIndicator(filled: true)
                        } else {
                            ServeIndicator(filled: false)
                            ServeIndicator(filled: false)
                        }
                    }
                    Text("Away: \(scoreData.awayScore)")
                    Button("+") {
                        print("+")
                        scoreData.awayScore += 1
                        PhoneConnector.shared.sendDataToPhone(["away" : scoreData.awayScore])
                    }
                    .buttonStyle(PlainButtonStyle())
                    .padding(8)
                    .frame(minWidth: 95)
                    .font(.system(size: 32))
                    .background(awayColor)
                    .clipShape(RoundedRectangle(cornerRadius: 8))
                    
                    Button("-") {
                        print("-")
                        if(scoreData.awayScore != 0){
                            scoreData.awayScore -= 1
                            PhoneConnector.shared.sendDataToPhone(["away" : scoreData.awayScore])
                        }
                    }
                    .buttonStyle(PlainButtonStyle())
                    .padding(8)
                    .frame(minWidth: 95)
                    .font(.system(size: 32))
                    .background(awayColor)
                    .clipShape(RoundedRectangle(cornerRadius: 8))
                }
            }
            
            
            VStack {
                HStack {
                    Button("Reset") {
                        print("Reset?")
                        isShowingAlert = true
                    }
                    .buttonStyle(PlainButtonStyle())
                    .padding(8)
                    .frame(minWidth: 95)
//                    .font(.system(size: 32))
                    .background(redColor)
                    .clipShape(RoundedRectangle(cornerRadius: 8))
                    .alert("Are you sure you want to reset the game?", isPresented: $isShowingAlert){
                        Button("Yes"){
                            print("Reset!!")
                        }
                        Button("No", role: .cancel){}
                    }
                    
                    Button("Serve") {
                        if (scoreData.serve != 3){
                            scoreData.serve += 1
                    } else {
                        scoreData.serve = 0
                    }
                        PhoneConnector.shared.sendDataToPhone(["serve": scoreData.serve])
                        print("next serve")
                    }
                    .buttonStyle(PlainButtonStyle())
                    .padding(8)
                    .frame(minWidth: 95)
//                    .font(.system(size: 32))
                    .background(yellowColor)
                    .clipShape(RoundedRectangle(cornerRadius: 8))
                }
            }
        }
        .onAppear {
            print("A wild watch appeared!")
            PhoneConnector.shared.sendDataToPhone(["Handshake" : ""])
        }
    }
        
}

#Preview {
    controlsView()
}

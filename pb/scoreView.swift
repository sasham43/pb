//
//  scoreView.swift
//  pb
//
//  Created by Sasha Kramer on 3/27/24.
//

import SwiftUI

struct scoreView: View {
    
    @State private var homeScore : Int = 0
    @State private var awayScore : Int = 0
    @State private var status : String = ""
    @State private var serve : Int = 1
    @State private var isGameInProgress : Bool = true
    @State private var isShowingAlert : Bool = false
    
    func resetGame(){
        homeScore = 0
        awayScore = 0
        status = ""
        serve = 1
        isGameInProgress = true
    }
    
    var body: some View {
        VStack {
            Text("Score")
            Text("\(status)")
            GeometryReader { geometry in
                VStack {
                    HStack(spacing: 50) {
                        VStack {
                            Text("\(homeScore)")
                                .font(.system(size: 70))
                            Text("Home")
                            Button("+") {
                                homeScore += 1
                                WatchConnector.shared.sendDataToWatch(["phone home" : "+"])
                            }
                            .font(.system(size: 50))
                            .disabled(!isGameInProgress)
                            Button("-") {
                                if(homeScore != 0){
                                    homeScore -= 1
                                }
                            }
                            .font(.system(size: 50))
                            .disabled(!isGameInProgress)
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
                        
                        VStack {
                            Text("\(awayScore)")
                                .font(.system(size: 70))
                            Text("Away")
                            Button("+") {
                                awayScore += 1
                            }
                            .font(.system(size: 50))
                            .disabled(!isGameInProgress)
                            Button("-") {
                                if(awayScore != 0){
                                    awayScore -= 1
                                }
                            }
                            .font(.system(size: 50))
                            .disabled(!isGameInProgress)
                            if(serve == 2){
                                ServeIndicator(filled: true)
                                ServeIndicator(filled: false)
                            } else if (serve == 3){
                                ServeIndicator(filled: true)
                                ServeIndicator(filled: true)
                            } else {
                                ServeIndicator(filled: false)
                                ServeIndicator(filled: false)
                            }
                        }
                    }
                    .frame(minWidth: geometry.size.width)
                    Spacer()
                    VStack {
                        Button("Reset") {
//                            resetGame()
                            isShowingAlert = true
                        }
                        .alert("Are you sure you want to reset the game?", isPresented: $isShowingAlert){
                            Button("Yes"){
                                resetGame()
                            }
                            Button("No", role: .cancel){}
                        }
                        Button("Next serve") {
                            if (serve != 3){
                                serve += 1
                            } else {
                                serve = 0
                            }
                        }
                    }
                    Spacer()
                }
                
            }
            .onChange(of: homeScore) {
                if(homeScore >= 11 && homeScore - awayScore >= 2) {
                    print("Home wins")
                    status = "Home wins"
                    isGameInProgress = false
                }
            }
            .onChange(of: awayScore) {
                if(awayScore >= 11 && awayScore - homeScore >= 2) {
                    print("Away wins")
                    status = "Away wins"
                    isGameInProgress = false
                }
            }
            Spacer()
        }
        
    }
}

#Preview {
    scoreView()
}

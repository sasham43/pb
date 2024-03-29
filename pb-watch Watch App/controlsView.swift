//
//  controlsView.swift
//  pb-watch Watch App
//
//  Created by Sasha Kramer on 3/27/24.
//

import SwiftUI

//class ScoreData: ObservableObject {
//    @Published var homeScore: Int = 0
//}

struct controlsView: View {
    
//    @EnvironmentObject public var homeScore : Int = 0
    @EnvironmentObject var scoreData : ScoreData
//    @State private var awayScore : Int = 0
//    @State private var status : String = ""
    @State private var serve : Int = 1
    @State private var isGameInProgress : Bool = true
    
    @State private var isShowingAlert : Bool = false
    
    
    var body: some View {
        VStack {
            HStack {
                VStack {
                    HStack {
                        Circle()
                            .fill(.blue)
                            .stroke(.blue, lineWidth: 1)
                            .frame(width: 10, height: 10)
                        Circle()
                            .fill(.clear)
                            .stroke(.blue, lineWidth: 1)
                            .frame(width: 10, height: 10)
                    }
                    Text("Home: \(scoreData.homeScore)")
                    Button("+") {
                        print("watch +")
                        PhoneConnector.shared.sendDataToPhone(["home" : scoreData.homeScore])
                    }
                    .font(.system(size: 32))
                    Button("-") {
                        print("-")
                        PhoneConnector.shared.sendDataToPhone(["home" : scoreData.homeScore])
                    }
                    .font(.system(size: 32))
                }
                VStack {
                    HStack {
                        Circle()
                            .fill(.clear)
                            .stroke(.blue, lineWidth: 1)
                            .frame(width: 10, height: 10)
                        Circle()
                            .fill(.clear)
                            .stroke(.blue, lineWidth: 1)
                            .frame(width: 10, height: 10)
                    }
                    Text("Away: \(scoreData.awayScore)")
                    Button("+") {
                        print("+")
                        PhoneConnector.shared.sendDataToPhone(["away" : scoreData.awayScore])
                    }
                    .font(.system(size: 32))
                    Button("-") {
                        print("-")
                        PhoneConnector.shared.sendDataToPhone(["away" : scoreData.awayScore])
                    }
                    .font(.system(size: 32))
                }
            }
            
            
            VStack {
                HStack {
                    Button("Reset") {
                        print("Reset?")
                        isShowingAlert = true
                    }
                    .alert("Are you sure you want to reset the game?", isPresented: $isShowingAlert){
                        Button("Yes"){
                            print("Reset!!")
                        }
                        Button("No", role: .cancel){}
                    }
                    Button("Serve") {
                        print("next serve")
                    }
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

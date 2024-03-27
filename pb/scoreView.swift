//
//  scoreView.swift
//  pb
//
//  Created by Sasha Kramer on 3/27/24.
//

import SwiftUI

struct scoreView: View {
    
    @State private var homeScore : Int = 0
    @State private var awayScore = 0
    
    @State private var status = ""
    
    var body: some View {
        VStack {
            Text("Score")
            Text("\(status)")
            GeometryReader { geometry in
                HStack {
                    VStack {
                        Text("Home: \(homeScore)")
                        Button("+") {
                            homeScore += 1
                        }
                        Button("-") {
                            homeScore -= 1
                        }
                    }
                    .padding(10)
                    VStack {
                        Text("Away: \(awayScore)")
                        Button("+") {
                            awayScore += 1
                        }
                        Button("-") {
                            awayScore -= 1
                        }
                    }
                }
                .frame(minWidth: geometry.size.width)
            }
            .onChange(of: homeScore) {
                if(homeScore >= 11 && homeScore - awayScore >= 2) {
                    print("Home wins")
                    status = "Home wins"
                }
            }
            .onChange(of: awayScore) {
                if(awayScore >= 11 && awayScore - homeScore >= 2) {
                    print("Away wins")
                    status = "Away wins"
                }
            }
            Button("Reset") {
                homeScore = 0
                awayScore = 0
                status = ""
            }
            Spacer()
        }
        
    }
}

#Preview {
    scoreView()
}

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
    
    @State private var serve : Int = 0
    
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
                        if(serve == 0){
                            Circle()
                                .fill(.black)
                                .stroke(.black, lineWidth: 1)
//                                .border(.white, width: )
                                .frame(width: 10, height: 10)
                            Circle()
                                .fill(.clear)
                                .stroke(.black, lineWidth: 1)
                                .frame(width: 10, height: 10)
                        } else if(serve == 1){
                            Circle()
                                .fill(.black)
                                .frame(width: 10, height: 10)
                            Circle()
                                .fill(.black)
                                .frame(width: 10, height: 10)
                        } else {
                            Circle()
                                .stroke(.black, lineWidth: 1)
                                .fill(.clear)
                                .frame(width: 10, height: 10)
                            
                            Circle()
                                .stroke(.black, lineWidth: 1)
                                .fill(.clear)
                                .frame(width: 10, height: 10)
                        }
                    }
                    .padding(10)
                    
                    VStack {
                        
                        Button("Reset") {
                            homeScore = 0
                            awayScore = 0
                            status = ""
                            serve = 0
                        }
                        Button("Next serve") {
                            if (serve != 3){
                                serve += 1
                            } else {
                                serve = 0
                            }
                        }
                    }
                    
                    VStack {
                        Text("Away: \(awayScore)")
                        Button("+") {
                            awayScore += 1
                        }
                        Button("-") {
                            awayScore -= 1
                        }
                        if(serve == 2){
                            Circle()
                                .fill(.black)
                                .stroke(.black, lineWidth: 1)
//                                .border(.white, width: )
                                .frame(width: 10, height: 10)
                            Circle()
                                .fill(.clear)
                                .stroke(.black, lineWidth: 1)
                                .frame(width: 10, height: 10)
                        } else if (serve == 3){
                            Circle()
                                .fill(.black)
                                .frame(width: 10, height: 10)
                            Circle()
                                .fill(.black)
                                .frame(width: 10, height: 10)
                        } else {
                            Circle()
                                .stroke(.black, lineWidth: 1)
                                .fill(.clear)
                                .frame(width: 10, height: 10)
                            
                            Circle()
                                .stroke(.black, lineWidth: 1)
                                .fill(.clear)
                                .frame(width: 10, height: 10)
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
            Spacer()
        }
        
    }
}

#Preview {
    scoreView()
}

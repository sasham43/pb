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
    
    var body: some View {
        Text("Score")
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
        
        
    }
}

#Preview {
    scoreView()
}

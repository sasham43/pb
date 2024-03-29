//
//  pb_watchApp.swift
//  pb-watch Watch App
//
//  Created by Sasha Kramer on 3/27/24.
//

import SwiftUI

class ScoreData: ObservableObject {
    static let shared = ScoreData()
    
    @Published var homeScore: Int = 0
    @Published var awayScore: Int = 0
    @Published var serve: Int = 1
}

@main
struct pb_watch_Watch_AppApp: App {
//    @EnvironmentObject var scoreData : ScoreData
    let scoreData = ScoreData.shared
    
    var body: some Scene {
        WindowGroup {
//            ContentView()
            controlsView()
                .environmentObject(scoreData)
        }
    }
}

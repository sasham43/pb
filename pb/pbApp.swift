//
//  pbApp.swift
//  pb
//
//  Created by Sasha Kramer on 3/27/24.
//

import SwiftUI
import SwiftData


class ScoreData: ObservableObject {
    static let shared = ScoreData()
    
    @Published var homeScore: Int = 0
    @Published var awayScore: Int = 0
}

@main
struct pbApp: App {
//    var sharedModelContainer: ModelContainer = {
//        let schema = Schema([
//            Item.self,
//        ])
//        let modelConfiguration = ModelConfiguration(schema: schema, isStoredInMemoryOnly: false)
//
//        do {
//            return try ModelContainer(for: schema, configurations: [modelConfiguration])
//        } catch {
//            fatalError("Could not create ModelContainer: \(error)")
//        }
//    }()
    let scoreData = ScoreData.shared

    var body: some Scene {
        WindowGroup {
//            ContentView()
            scoreView()
                .environmentObject(scoreData)
        }
        
//        .modelContainer(sharedModelContainer)
    }
}

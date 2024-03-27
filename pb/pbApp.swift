//
//  pbApp.swift
//  pb
//
//  Created by Sasha Kramer on 3/27/24.
//

import SwiftUI
import SwiftData

@main
struct pbApp: App {
    var sharedModelContainer: ModelContainer = {
        let schema = Schema([
            Item.self,
        ])
        let modelConfiguration = ModelConfiguration(schema: schema, isStoredInMemoryOnly: false)

        do {
            return try ModelContainer(for: schema, configurations: [modelConfiguration])
        } catch {
            fatalError("Could not create ModelContainer: \(error)")
        }
    }()

    var body: some Scene {
        WindowGroup {
//            ContentView()
            scoreView()
        }
        .modelContainer(sharedModelContainer)
    }
}

//
//  CompassChallengeApp.swift
//  CompassChallenge
//
//  Created by Joaquin Duran on 14/05/2024.
//

import SwiftUI
import SwiftData

@main
struct CompassChallengeApp: App {
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
        let emojiService = EmojiServiceImplementation()
        let viewModel = EmojiViewModel(service: emojiService)

        WindowGroup {
            EmojiView(viewModel: viewModel)
        }
    }
}

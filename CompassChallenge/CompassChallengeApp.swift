import SwiftUI
import SwiftData

@main
struct CompassChallengeApp: App {

    var body: some Scene {
        let emojiService = EmojiServiceImplementation()
        let viewModel = EmojiViewModel(service: emojiService)

        WindowGroup {
            EmojiView(viewModel: viewModel)
        }.modelContainer(for: Emoji_SwiftData.self, inMemory: false)
    }
}

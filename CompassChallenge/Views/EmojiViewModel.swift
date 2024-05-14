import Foundation
import Combine

@MainActor
class EmojiViewModel: ObservableObject {
    @Published var categories = [String: [Emoji]]()
    @Published var isLoading = false
    private var emojiService: EmojiService
    private var cancellables = Set<AnyCancellable>()

    init(service: EmojiService) {
        self.emojiService = service
    }

    func fetchEmojis() {
        isLoading = true
        Task {
            do {
                let emojis = try await emojiService.fetchAndStoreEmojis()
                self.isLoading = false
                self.categorizeEmojis(emojis)
            } catch {
                self.isLoading = false
                print("Failed to fetch emojis: \(error)")
            }
        }
    }

    private func categorizeEmojis(_ emojis: [Emoji]) {
        var newCategories = [String: [Emoji]]()
        emojis.forEach { emoji in
            newCategories[emoji.category?.rawValue ?? "", default: []].append(emoji)
        }
        self.categories = newCategories
    }
}

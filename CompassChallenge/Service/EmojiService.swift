import Foundation
import SwiftData
import CoreData

class EmojiServiceImplementation: EmojiService {
    private let urlString = "https://emojihub.yurace.pro/api/all"
    var container: ModelContainer?
    var context: ModelContext?

        
    func fetchAndStoreEmojis() async throws -> [Emoji] {
        do {
            return try await fetchFromNetwork()
        } catch {
            return try await fetchFromLocalCache()
        }
    }
        
    
    private func fetchFromNetwork() async throws -> [Emoji] {
        container = try ModelContainer(for: Emoji_SwiftData.self)
        context = ModelContext(container!)
        
          guard let url = URL(string: urlString) else {
              throw URLError(.badURL)
          }
          
          let (data, _) = try await URLSession.shared.data(from: url)
          let decoder = JSONDecoder()
          let emojis = try decoder.decode([Emoji].self, from: data)
          
        
          try emojis.forEach { emoji in
              if let emoji_swiftData = emoji.toSwiftDataModel() {
                  context?.insert(emoji_swiftData)
                  try context?.save()
              }
          }
          return emojis
      }

    

      private func fetchFromLocalCache() async throws -> [Emoji] {
          let container = try ModelContainer(for: Emoji_SwiftData.self)
          let context = ModelContext(container)

          let descriptor = FetchDescriptor<Emoji_SwiftData>()
          let results = try context.fetch(descriptor)
          
          print(results.count)

          let emojis = results.compactMap { $0.toEmojiModel() }
          
          return emojis
        
      }
}

protocol EmojiService {
    func fetchAndStoreEmojis() async throws -> [Emoji]
}

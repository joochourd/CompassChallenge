import SwiftUI

struct EmojiView: View {
    @StateObject var viewModel: EmojiViewModel

    var body: some View {
        NavigationView {
            List {
                ForEach(viewModel.categories.keys.sorted(), id: \.self) { key in
                    NavigationLink(destination: EmojiGridView(emojis: viewModel.categories[key] ?? [])) {
                        Text(key).font(.headline)
                    }
                }
            }
            .navigationTitle("Emoji Categories")
            .onAppear {
                viewModel.fetchEmojis()
            }
        }
    }
}

struct EmojiGridView: View {
    let emojis: [Emoji]

    let columns: [GridItem] = Array(repeating: .init(.flexible()), count: 4)

    var body: some View {
        ScrollView {
            LazyVGrid(columns: columns) {
                ForEach(emojis, id: \.self) { emoji in
                    if let unicodeScalar = parseUnicode(unicodeString: emoji.unicode?.first ?? "") {
                        Text(String(unicodeScalar))
                            .font(.largeTitle)
                            .padding()
                    }
                }
            }
        }
    }

    func parseUnicode(unicodeString: String) -> Unicode.Scalar? {
        let hexCode = unicodeString.dropFirst(2) // Drop the 'U+'
        if let codePoint = UInt32(hexCode, radix: 16), let scalar = Unicode.Scalar(codePoint) {
            return scalar
        }
        return nil
    }
}


#Preview {
    EmojiView(viewModel: EmojiViewModel(service: EmojiServiceMock()))
}

import Foundation

fileprivate class EmojiServiceMock: EmojiService {
    func fetchAndStoreEmojis() async throws -> [Emoji] {
        let jsonData = """
        [
            {
                "name": "grinning face",
                "category": "smileys and people",
                "group": "face positive",
                "htmlCode": ["\\u0026#128512;"],
                "unicode": ["U+1F600"]
            },
            {
                "name": "grinning face with smiling eyes",
                "category": "smileys and people",
                "group": "face positive",
                "htmlCode": ["\\u0026#128513;"],
                "unicode": ["U+1F601"]
            },
            {
                "name": "face with tears of joy",
                "category": "smileys and people",
                "group": "face positive",
                "htmlCode": ["\\u0026#128514;"],
                "unicode": ["U+1F602"]
            }
        ]
        """.data(using: .utf8)!
        
        let decoder = JSONDecoder()
        let emojis = try decoder.decode([Emoji].self, from: jsonData)
        return emojis
    }
}

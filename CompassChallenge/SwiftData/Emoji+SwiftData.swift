import Foundation
import SwiftData

@Model
class Emoji_SwiftData {
    @Attribute(.unique) var name: String
    @Attribute var group: String
    @Attribute var htmlCode: [String]?
    @Attribute var unicode: [String]?
    @Attribute var category: String?
    
    init(name: String, group: String, htmlCode: [String]?, unicode: [String]?, category: String?) {
        self.name = name
        self.group = group
        self.htmlCode = htmlCode
        self.unicode = unicode
        self.category = category
    }
}


extension Emoji {
    func toSwiftDataModel() -> Emoji_SwiftData? {
        guard let name = self.name, let group = self.group else { return nil }
        return Emoji_SwiftData(name: name, group: group.rawValue, htmlCode: self.htmlCode, unicode: self.unicode, category: self.category?.rawValue ?? "")
        }
}

extension Emoji_SwiftData {
    func toEmojiModel() -> Emoji? {
        return Emoji(
            name: name,
            category: Category(rawValue: self.category ?? ""),
            group: Group(rawValue: group),
            htmlCode: self.htmlCode,
            unicode: self.unicode
        )
    }
}


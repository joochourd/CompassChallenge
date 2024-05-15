import Foundation


struct Emoji: Decodable, Hashable {
    let name: String?
    let category: Category?
    let group: Group?
    let htmlCode, unicode: [String]?
}

enum Category: String, Codable, Sendable {
    case activities = "activities"
    case animalsAndNature = "animals and nature"
    case flags = "flags"
    case foodAndDrink = "food and drink"
    case objects = "objects"
    case smileysAndPeople = "smileys and people"
    case symbols = "symbols"
    case travelAndPlaces = "travel and places"
}

enum Group: String, Codable, Sendable {
    case activities = "activities"
    case animalAmphibian = "animal amphibian"
    case animalBird = "animal bird"
    case animalBug = "animal bug"
    case animalMammal = "animal mammal"
    case animalMarine = "animal marine"
    case animalReptile = "animal reptile"
    case body = "body"
    case catFace = "cat face"
    case clothing = "clothing"
    case creatureFace = "creature face"
    case dishware = "dishware"
    case drink = "drink"
    case emotion = "emotion"
    case faceNegative = "face negative"
    case faceNeutral = "face neutral"
    case facePositive = "face positive"
    case faceRole = "face role"
    case faceSick = "face sick"
    case family = "family"
    case flags = "flags"
    case foodAsian = "food asian"
    case foodFruit = "food fruit"
    case foodPrepared = "food prepared"
    case foodSweet = "food sweet"
    case foodVegetable = "food vegetable"
    case monkeyFace = "monkey face"
    case objects = "objects"
    case person = "person"
    case personActivity = "person activity"
    case personGesture = "person gesture"
    case personRole = "person role"
    case plantFlower = "plant flower"
    case plantOther = "plant other"
    case skinTone = "skin tone"
    case symbols = "symbols"
    case travelAndPlaces = "travel and places"
}



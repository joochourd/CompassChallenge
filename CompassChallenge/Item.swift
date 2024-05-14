//
//  Item.swift
//  CompassChallenge
//
//  Created by Joaquin Duran on 14/05/2024.
//

import Foundation
import SwiftData

@Model
final class Item {
    var timestamp: Date
    
    init(timestamp: Date) {
        self.timestamp = timestamp
    }
}

//
//  Symbol.swift
//  Reels
//
//  Created by Jmy on 2023/03/13.
//

import SwiftUI

// enum Symbol: CaseIterable {
//    static let house_fill = "house.fill"
//    static let magnifyingglass = "magnifyingglass"
//    static let play_rectangle = "play.rectangle"
//    static let suit_heart = "suit.heart"
//    static let person_circle = "person.circle"
// }

enum Symbol: String, CaseIterable {
    case house_fill
    case magnifyingglass
    case play_rectangle
    case suit_heart
    case person_circle

    init() {
        self = .play_rectangle
    }

    var fullName: String {
        switch self {
        case .house_fill: return "house.fill"
        case .magnifyingglass: return "magnifyingglass"
        case .play_rectangle: return "play.rectangle"
        case .suit_heart: return "suit.heart"
        case .person_circle: return "person.circle"
        }
    }
}

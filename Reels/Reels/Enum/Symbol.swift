//
//  Symbol.swift
//  Reels
//
//  Created by Jmy on 2023/03/13.
//

import SwiftUI

enum Symbol: String, CaseIterable {
    case houseFill
    case magnifyingglass
    case playRectangle
    case suitHeart
    case personCircle

    init() {
        self = .playRectangle
    }

    var imageName: String {
        switch self {
        case .houseFill: return "house.fill"
        case .magnifyingglass: return "magnifyingglass"
        case .playRectangle: return "play.rectangle"
        case .suitHeart: return "suit.heart"
        case .personCircle: return "person.circle"
        }
    }
}

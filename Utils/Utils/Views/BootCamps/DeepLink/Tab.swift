//
//  Tab.swift
//  Utils
//
//  Created by Jmy on 2/4/24.
//

import SwiftUI

enum Tab: String, CaseIterable {
    case home = "Home"
    case favourites = "Favourites"
    case settings = "Settings"

    var symbolImage: String {
        switch self {
        case .home: return "house.fill"
        case .favourites: return "heart.fill"
        case .settings: return "gear"
        }
    }

    static func convert(from: String) -> Self? {
        return allCases.first { tab in
            tab.rawValue.lowercased() == from.lowercased()
        }
    }
}

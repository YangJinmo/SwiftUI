//
//  FavouriteStack.swift
//  Utils
//
//  Created by Jmy on 2/4/24.
//

import SwiftUI

enum FavouriteStack: String, CaseIterable {
    case iJustine
    case kaviya = "Kaviya"
    case jenna = "Jenna"

    static func convert(from: String) -> Self? {
        return allCases.first { tab in
            tab.rawValue.lowercased() == from.lowercased()
        }
    }
}

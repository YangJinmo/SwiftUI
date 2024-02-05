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
    case jenna1 = "Jenna1"
    case jenna2 = "Jenna2"
    case jenna3 = "Jenna3"
    case jenna4 = "Jenna4"
    case jenna5 = "Jenna5"
    case jenna6 = "Jenna6"
    case jenna7 = "Jenna7"
    case jenna8 = "Jenna8"
    case jenna9 = "Jenna9"
    case jenna10 = "Jenna10"
    case jenna11 = "Jenna11"
    case jenna12 = "Jenna12"
    case jenna13 = "Jenna13"
    case jenna14 = "Jenna14"
    case jenna15 = "Jenna15"
    case jenna16 = "Jenna16"
    case jenna17 = "Jenna17"
    case jenna18 = "Jenna18"
    case jenna19 = "Jenna19"
    case jenna20 = "Jenna20"
    case jenna21 = "Jenna21"
    case jenna22 = "Jenna22"
    case jenna23 = "Jenna23"
    case jenna24 = "Jenna24"
    case jenna25 = "Jenna25"
    case jenna26 = "Jenna26"
    case jenna27 = "Jenna27"
    case jenna28 = "Jenna28"
    case jenna29 = "Jenna29"

    static func convert(from: String) -> Self? {
        return allCases.first { tab in
            tab.rawValue.lowercased() == from.lowercased()
        }
    }
}

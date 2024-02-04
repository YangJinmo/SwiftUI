//
//  HomeStack.swift
//  Utils
//
//  Created by Jmy on 2/4/24.
//

import SwiftUI

enum HomeStack: String, CaseIterable {
    case myPosts = "My Posts"
    case oldPosts = "Old Posts"
    case lastestPosts = "Lastest Posts"
    case deletedPosts = "Deleted Posts"

    static func convert(from: String) -> Self? {
        return allCases.first { tab in
            tab.rawValue.lowercased() == from.lowercased()
        }
    }
}

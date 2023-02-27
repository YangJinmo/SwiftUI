//
//  Tab.swift
//  Animated Header
//
//  Created by Jmy on 2023/02/27.
//

import Foundation

struct Tab: Identifiable {
    var id = UUID().uuidString
    var tab: String
    var foods: [Food]
}

var tabsItems = [
    Tab(
        tab: "Order Again",
        foods: foods.shuffled()
    ),
    Tab(
        tab: "Picked For you",
        foods: foods.shuffled()
    ),
    Tab(
        tab: "Starters",
        foods: foods.shuffled()
    ),
    Tab(
        tab: "Gimpub Sushi",
        foods: foods.shuffled()
    )
]

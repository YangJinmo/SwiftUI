//
//  Course.swift
//  CustomTransitionBetweenScreens
//
//  Created by Jmy on 2023/05/20.
//

import SwiftUI

struct Course: Identifiable {
    var id = UUID().uuidString
    var title: String
}

var courses = [
    Course(title: "SwiftUI for iOS 15"),
    Course(title: "React Hooks Advanced"),
    Course(title: "UI Design for iOS 15"),
    Course(title: "Flutter for designers"),
]

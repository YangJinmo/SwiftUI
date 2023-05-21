//
//  Course.swift
//  CustomTransitionBetweenScreens
//
//  Created by Jmy on 2023/05/20.
//

import SwiftUI

struct Course: Identifiable {
    var id = UUID()
    var title: String
    var subtitle: String
    var text: String
    var image: String
    var logo: String
}

var courses = [
    Course(
        title: "SwiftUI for iOS 15",
        subtitle: "20 sections - 3 hours",
        text: "Build an iOS app for iOS 15 with custom layouts, animations and...",
        image: "swiftui-96x96_2x",
        logo: "swiftui-96x96_2x"
    ),
    Course(
        title: "UI Design for iOS 15",
        subtitle: "20 sections - 3 hours",
        text: "Design an iOS app for iOS 15 with custom layouts, animations and...",
        image: "Swift",
        logo: "figmaLogo"
    ),
    Course(
        title: "Flutter for designers",
        subtitle: "20 sections - 3 hours",
        text: "Flutter is a relatively new toolkit that makes it easy to build cross-flatform apps that look gorgeous and is easy to use",
        image: "swiftui-96x96_2x",
        logo: "swiftui-96x96_2x"),
    Course(
        title: "React Hooks Advanced",
        subtitle: "20 sections - 3 hours",
        text: "Learn how to build a website with Typescript, Hooks, Contentful and Gatsby Cloud",
        image: "swiftui-96x96_2x",
        logo: "swiftui-96x96_2x"
    ),
]

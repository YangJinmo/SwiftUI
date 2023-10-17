//
//  Color.swift
//  Utils
//
//  Created by Jmy on 2023/06/05.
//

import SwiftUI

extension Color {
    static let limeGreen = Color.rgba(4, 219, 108, 1)
    static let emeraldGreen = Color.rgba(5, 197, 147, 1)
    static let lightYellow = Color.rgba(252, 255, 125, 1)

    static let gray800 = Color.rgba(23, 27, 28, 1)
    static let gray700 = Color.rgba(46, 54, 58, 1)
    static let gray600 = Color.rgba(65, 71, 76, 1)
    static let gray500 = Color.rgba(90, 97, 102, 1)
    static let gray400 = Color.rgba(153, 159, 164, 1)
    static let gray300 = Color.rgba(197, 200, 206, 1)
    static let gray200 = Color.rgba(247, 248, 249, 1)
    static let gray100 = Color.rgba(253, 253, 253, 1)
}

extension Color {
    init(hex: UInt, opacity: Double = 1) {
        let color = (
            red: (hex >> 16) & 0xFF,
            green: (hex >> 08) & 0xFF,
            blue: (hex >> 00) & 0xFF
        )

        // print("red: \(color.red), green: \(color.green), blue: \(color.blue), opacity: \(opacity)")

        self.init(
            .sRGB,
            red: Double(color.red) / 255,
            green: Double(color.green) / 255,
            blue: Double(color.blue) / 255,
            opacity: opacity
        )
    }

    static func rgba(_ red: CGFloat, _ green: CGFloat, _ blue: CGFloat, _ opacity: CGFloat) -> Color {
        .init(red: red / 255, green: green / 255, blue: blue / 255, opacity: opacity)
    }

    static func random(_ opacity: CGFloat = 1) -> Color {
        .init(red: .random(in: 0 ... 1), green: .random(in: 0 ... 1), blue: .random(in: 0 ... 1), opacity: opacity)
    }
}

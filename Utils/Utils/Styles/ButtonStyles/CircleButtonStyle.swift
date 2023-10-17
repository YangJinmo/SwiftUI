//
//  CircleButtonStyle.swift
//  Utils
//
//  Created by Jmy on 2023/10/17.
//

import SwiftUI

struct CircleButtonStyle: ButtonStyle {
    let backgroundColor: Color

    func makeBody(configuration: Configuration) -> some View {
        configuration.label
            .padding(8)
            .background(backgroundColor)
            .clipShape(Circle())
            .scaleEffect(configuration.isPressed ? 0.88 : 1.0)
    }
}

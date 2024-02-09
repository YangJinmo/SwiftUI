//
//  ButtonStyleBootcamp.swift
//  Utils
//
//  Created by Jmy on 2/9/24.
//

import SwiftUI

struct PressableButtonStyle: ButtonStyle {
    let scaledAmount: CGFloat

    init(scaledAmount: CGFloat) {
        self.scaledAmount = scaledAmount
    }

    func makeBody(configuration: Configuration) -> some View {
        configuration.label
            // .brightness(configuration.isPressed ? 0.05 : 0)
            .opacity(configuration.isPressed ? 0.9 : 1.0)
            .scaleEffect(configuration.isPressed ? scaledAmount : 1.0)
    }
}

extension View {
    func withPressableStyle(scaledAmount: CGFloat = 0.9) -> some View {
        buttonStyle(PressableButtonStyle(scaledAmount: scaledAmount))
    }
}

struct ButtonStyleBootcamp: View {
    var body: some View {
        Button(action: {
        }, label: {
            Text("Click Me")
                .font(.headline)
                .withDefaultButtonFommatting()

        })
        // .buttonStyle(DefaultButtonStyle())
        // .buttonStyle(PlainButtonStyle())
        // .buttonStyle(PressableButtonStyle())
        .withPressableStyle(scaledAmount: 0.9)
        .padding()
    }
}

#Preview {
    ButtonStyleBootcamp()
}

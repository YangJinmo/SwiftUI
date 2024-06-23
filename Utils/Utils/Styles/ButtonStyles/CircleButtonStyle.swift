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
            .scaleEffect(configuration.isPressed ? 0.95 : 1.0)
    }
}

extension ButtonStyle where Self == CircleButtonStyle {
    static func circle(backgroundColor: Color) -> CircleButtonStyle { .init(backgroundColor: backgroundColor) }
}

struct CircleButtonStylePreview: View {
    struct Category: Identifiable {
        let id: Int
        let name: String

        var isOn = false
    }

    @State private var category = Category(id: 0, name: "8")

    var body: some View {
        Button {
            category.isOn.toggle()
        } label: {
            Image(systemName: "heart")
                .imageScale(.medium)
                .symbolVariant(category.isOn ? .fill : .none)
                .foregroundColor(category.isOn ? .red : .red.opacity(0.8))
        }
        .buttonStyle(.circle(backgroundColor: .primary))
    }
}

#Preview {
    CircleButtonStylePreview()
}

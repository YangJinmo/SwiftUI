//
//  RoundedRectangleButtonStyle.swift
//  Utils
//
//  Created by Jmy on 2023/08/16.
//

import SwiftUI

struct RoundedRectangleButtonStyle: ButtonStyle {
    @Binding var isOn: Bool

    func makeBody(configuration: Configuration) -> some View {
        configuration.label
            .font(.subheadline)
            .foregroundColor(isOn ? .black : .gray100)
            .padding(.horizontal, 16)
            .padding(.vertical, 8)
            .background(isOn ? .accentColor : Color.gray700)
            .cornerRadius(8)
            .contentShape(RoundedRectangle(cornerRadius: 8, style: .continuous))
            .scaleEffect(configuration.isPressed ? 0.95 : 1.0)
    }
}

extension ButtonStyle where Self == RoundedRectangleButtonStyle {
    static func roundedRectangle(isOn: Binding<Bool> = .constant(true)) -> RoundedRectangleButtonStyle { .init(isOn: isOn) }
}

struct RoundedRectangleButtonStylePreview: View {
    struct Category: Identifiable {
        let id: Int
        let name: String

        var isOn = false
    }

    @State private var category = Category(id: 0, name: "RoundedRectangleButtonStyle")

    var body: some View {
        Button {
            category.isOn.toggle()
        } label: {
            Text(category.name)
        }
        .buttonStyle(.roundedRectangle(isOn: $category.isOn))
    }
}

#Preview {
    RoundedRectangleButtonStylePreview()
}

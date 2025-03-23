//
//  CapsuleToggleButtonStyle.swift
//  Utils
//
//  Created by Jmy on 3/26/25.
//

import SwiftUI

struct CapsuleToggleButtonStyle: ButtonStyle {
    @Binding var isOn: Bool

    func makeBody(configuration: Configuration) -> some View {
        configuration.label
            .foregroundColor(isOn ? .white : .accentColor)
            .padding(.horizontal, 16)
            .padding(.vertical, 8)
            .background(isOn ? Color.accentColor : .white)
            .clipShape(Capsule())
            .contentShape(Capsule())
            .overlay(Capsule().strokeBorder(isOn ? .clear : Color.accentColor, lineWidth: 0.5))
            .scaleEffect(configuration.isPressed ? 0.95 : 1.0)
    }
}

extension ButtonStyle where Self == CapsuleToggleButtonStyle {
    static func capsuleToggle(isOn: Binding<Bool> = .constant(true)) -> CapsuleToggleButtonStyle { .init(isOn: isOn) }
}

struct CapsuleToggleButtonStylePreview: View {
    struct Category: Identifiable {
        let id: Int
        let name: String

        var isOn = false
    }

    @State private var category = Category(id: 0, name: "CapsuleToggleButtonStyle")

    var body: some View {
        Button {
            category.isOn.toggle()
        } label: {
            Text(category.name)
        }
        .buttonStyle(.capsuleToggle(isOn: $category.isOn))
    }
}

#Preview {
    CapsuleToggleButtonStylePreview()
}

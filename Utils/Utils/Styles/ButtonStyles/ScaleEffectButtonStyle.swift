//
//  ScaleEffectButtonStyle.swift
//  Utils
//
//  Created by Jmy on 2023/11/09.
//

import SwiftUI

struct ScaleEffectButtonStyle: ButtonStyle {
    func makeBody(configuration: Configuration) -> some View {
        configuration.label
            .scaleEffect(configuration.isPressed ? 0.88 : 1.0)
    }
}

extension ButtonStyle where Self == ScaleEffectButtonStyle {
    static var scaleEffect: ScaleEffectButtonStyle { .init() }
}

struct ScaleEffectButtonStylePreview: View {
    struct Category: Identifiable {
        let id: Int
        let name: String

        var isOn = false
    }

    @State private var category = Category(id: 0, name: "ScaleEffectButtonStyle")

    var body: some View {
        Button {
            category.isOn.toggle()
        } label: {
            Text(category.name)
                .font(.subheadline)
                .foregroundColor(category.isOn ? .black : .gray100)
                .padding(.horizontal, 16)
                .padding(.vertical, 8)
                .background(category.isOn ? .accentColor : Color.gray700)
                .clipShape(Capsule())
        }
        .buttonStyle(.scaleEffect)
    }
}

struct ScaleEffectButtonStyle_Previews: PreviewProvider {
    static var previews: some View {
        ScaleEffectButtonStylePreview()
    }
}

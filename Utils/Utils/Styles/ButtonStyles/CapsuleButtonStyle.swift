//
//  CapsuleButtonStyle.swift
//  Utils
//
//  Created by Jmy on 2023/08/14.
//

import SwiftUI

struct CapsuleButtonStyle: ButtonStyle {
    @Binding var isOn: Bool

    func makeBody(configuration: Configuration) -> some View {
        configuration.label
            .font(.subheadline)
            .foregroundColor(isOn ? .black : .gray100)
            .padding(.horizontal, 16)
            .padding(.vertical, 8)
            .background(isOn ? .accentColor : Color.gray700)
            .clipShape(Capsule())
            .scaleEffect(configuration.isPressed ? 0.88 : 1.0)
    }
}

struct CapsuleButtonStyle_Previews: PreviewProvider {
    static var previews: some View {
        CapsuleButtonStylePreview()
    }
}

struct CapsuleButtonStylePreview: View {
    struct Category: Identifiable {
        let id: Int
        let name: String

        var isOn = false
    }

    @State private var category = Category(id: 0, name: "CapsuleButtonStyle")

    var body: some View {
        Button {
            category.isOn.toggle()
        } label: {
            Text(category.name)
        }
        .buttonStyle(CapsuleButtonStyle(isOn: $category.isOn))
    }
}

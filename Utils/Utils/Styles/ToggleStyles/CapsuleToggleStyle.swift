//
//  CapsuleToggleStyle.swift
//  Utils
//
//  Created by Jmy on 2023/08/09.
//

import SwiftUI

struct CapsuleToggleStyle: ToggleStyle {
    func makeBody(configuration: Configuration) -> some View {
        Button {
            configuration.isOn.toggle()
        } label: {
            configuration.label
                .font(.subheadline)
                .foregroundColor(configuration.isOn ? .black : .gray100)
                .padding(.horizontal, 16)
                .padding(.vertical, 8)
                .background(configuration.isOn ? .accentColor : Color.gray700)
                .clipShape(Capsule())
        }
    }
}

extension ToggleStyle where Self == CapsuleToggleStyle {
    static var capsule: CapsuleToggleStyle { .init() }
}

struct CapsuleToggleStyle_Previews: PreviewProvider {
    static var previews: some View {
        CapsuleToggleStylePreview()
    }
}

struct CapsuleToggleStylePreview: View {
    @State private var isOn: Bool = false

    var body: some View {
        Toggle("CapsuleToggleStyle", isOn: $isOn)
            .toggleStyle(.capsule)
    }
}

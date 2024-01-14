//
//  RoundedRectangleToggleStyle.swift
//  Utils
//
//  Created by Jmy on 2023/08/12.
//

import SwiftUI

struct RoundedRectangleToggleStyle: ToggleStyle {
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
                .cornerRadius(8)
        }
    }
}

extension ToggleStyle where Self == RoundedRectangleToggleStyle {
    static var roundedRectangle: RoundedRectangleToggleStyle { .init() }
}

struct RoundedRectangleToggleStylePreview: View {
    @State private var isOn: Bool = false

    var body: some View {
        Toggle("RoundedRectangleToggleStyle", isOn: $isOn)
            .toggleStyle(.roundedRectangle)
    }
}

#Preview {
    RoundedRectangleToggleStylePreview()
}

//
//  RoundedRectangleStrokeBorderButtonStyle.swift
//  Utils
//
//  Created by Jmy on 3/2/25.
//

import SwiftUI

struct RoundedRectangleStrokeBorderButtonStyle: ButtonStyle {
    let radius: CGFloat

    func makeBody(configuration: Configuration) -> some View {
        configuration.label
            .foregroundColor(.white)
            .cornerRadius(radius)
            .contentShape(RoundedRectangle(cornerRadius: radius, style: .continuous))
            .overlay(RoundedRectangle(cornerRadius: radius, style: .continuous).strokeBorder(.white, lineWidth: 0.5))
            .scaleEffect(configuration.isPressed ? 0.95 : 1.0)
    }
}

extension ButtonStyle where Self == RoundedRectangleStrokeBorderButtonStyle {
    static func roundedRectangleStrokeBorder(cornerRadius radius: CGFloat = 12) -> RoundedRectangleStrokeBorderButtonStyle { .init(radius: radius) }
}

struct RoundedRectangleStrokeBorderButtonStylePreview: View {
    var body: some View {
        ZStack {
            Color.secondary.ignoresSafeArea()
            HStack {
                Spacer()

                Button {
                } label: {
                    HStack(spacing: 4) {
                        Text("Detail")

                        Image(systemName: "chevron.right")
                            .frame(width: 24, height: 24)
                    }
                    .padding(.leading, 16)
                    .padding(.trailing, 8)
                    .padding(.vertical, 8)
                }
                .buttonStyle(.roundedRectangleStrokeBorder())
                .padding()
            }
        }
    }
}

#Preview {
    RoundedRectangleStrokeBorderButtonStylePreview()
}

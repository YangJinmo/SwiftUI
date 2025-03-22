//
//  CapsuleStrokeBorderButtonStyle.swift
//  Utils
//
//  Created by Jmy on 3/26/25.
//

import SwiftUI

struct CapsuleStrokeBorderButtonStyle: ButtonStyle {
    let color: Color

    func makeBody(configuration: Configuration) -> some View {
        configuration.label
            .clipShape(Capsule())
            .contentShape(Capsule())
            .overlay(Capsule().strokeBorder(color, lineWidth: 0.5))
            .scaleEffect(configuration.isPressed ? 0.95 : 1.0)
    }
}

extension ButtonStyle where Self == CapsuleStrokeBorderButtonStyle {
    static func capsuleStrokeBorder(borderColor color: Color = .white) -> CapsuleStrokeBorderButtonStyle {
        .init(color: color)
    }
}

struct CapsuleStrokeBorderButtonStylePreview: View {
    var body: some View {
        ZStack {
            Color.secondary.ignoresSafeArea()

            HStack {
                Spacer()

                Button {
                } label: {
                    Image(systemName: "line.3.horizontal.decrease")
                        .frame(width: 24, height: 24)
                        .padding(8)
                }
                .buttonStyle(.capsuleStrokeBorder())

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
                .buttonStyle(.capsuleStrokeBorder())
                .padding()
            }
        }
    }
}

#Preview {
    CapsuleStrokeBorderButtonStylePreview()
}

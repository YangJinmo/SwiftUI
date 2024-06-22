//
//  View.swift
//  Utils
//
//  Created by Jmy on 2023/06/24.
//

import SwiftUI

extension View {
    // https://developer.apple.com/design/human-interface-guidelines/buttons
    // As a general rule, a button needs a hit region of at least 44x44 pt — in visionOS, 60x60 pt
    func setHitRegion(size: CGFloat = 44) -> some View {
        frame(width: size, height: size)
    }

    func toAnyView() -> AnyView {
        AnyView(self)
    }

    func shadowedStyle() -> some View {
        shadow(color: .black.opacity(0.08), radius: 2, x: 0, y: 0)
            .shadow(color: .black.opacity(0.16), radius: 24, x: 0, y: 0)
    }

    func placeholder<Content: View>(
        when shouldShow: Bool,
        alignment: Alignment = .leading,
        @ViewBuilder placeholder: () -> Content
    ) -> some View {
        ZStack(alignment: alignment) {
            placeholder().opacity(shouldShow ? 1 : 0)
            self
        }
    }

    @ViewBuilder func isHidden(_ isHidden: Bool, remove: Bool = false) -> some View {
        if isHidden {
            if !remove {
                hidden()
            }
        } else {
            self
        }
    }

    @ViewBuilder func `if`<Transform: View>(_ condition: Bool, transform: (Self) -> Transform) -> some View {
        if condition {
            transform(self)
        } else {
            self
        }
    }
}

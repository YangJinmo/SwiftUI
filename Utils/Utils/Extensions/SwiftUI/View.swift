//
//  View.swift
//  Utils
//
//  Created by Jmy on 2023/06/24.
//

import SwiftUI

extension View {
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
}

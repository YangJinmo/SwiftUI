//
//  BackgroundViewModifier.swift
//  Utils
//
//  Created by Jmy on 2023/06/27.
//

import SwiftUI

struct BackgroundViewModifier: ViewModifier {
    func body(content: Content) -> some View {
        ZStack {
            Color.gray800.ignoresSafeArea()

            content
        }
    }
}

extension View {
    func backgroundViewModifier() -> some View {
        modifier(BackgroundViewModifier())
    }
}

#Preview {
    EmptyView()
        .backgroundViewModifier()
}

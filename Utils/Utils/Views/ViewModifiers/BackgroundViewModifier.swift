//
//  BackgroundViewModifier.swift
//  Utils
//
//  Created by Jmy on 2023/06/27.
//

import SwiftUI

struct BackgroundViewModifier: ViewModifier {
    let color: Color

    func body(content: Content) -> some View {
        ZStack {
            color.ignoresSafeArea()

            content
        }
    }
}

extension View {
    func backgroundViewModifier(color: Color = .black) -> some View {
        modifier(BackgroundViewModifier(color: color))
    }
}

#Preview {
    EmptyView()
        .backgroundViewModifier()
}

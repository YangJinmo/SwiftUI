//
//  ToggleScrollEnabledViewModifier.swift
//  Utils
//
//  Created by Jmy on 2023/08/30.
//

import SwiftUI

struct ToggleScrollEnabledViewModifier: ViewModifier {
    var enabled: Bool

    func body(content: Content) -> some View {
        if enabled {
            content
        } else {
            content
                .simultaneousGesture(DragGesture(minimumDistance: 0))
        }
    }
}

extension View {
    func isScrollEnabled(_ enabled: Bool) -> some View {
        modifier(ToggleScrollEnabledViewModifier(enabled: enabled))
    }
}

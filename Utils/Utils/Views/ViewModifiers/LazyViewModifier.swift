//
//  LazyViewModifier.swift
//  Utils
//
//  Created by Jmy on 10/26/24.
//

import SwiftUI

struct LazyViewModifier: ViewModifier {
    func body(content: Content) -> some View {
        LazyView(content)
    }
}

extension View {
    func lazyView() -> some View {
        modifier(LazyViewModifier())
    }
}

//
//  CircularProgressViewModifier.swift
//  Utils
//
//  Created by Jmy on 9/24/24.
//

import SwiftUI

struct CircularProgressViewModifier: ViewModifier {
    func body(content: Content) -> some View {
        ZStack {
            content

            CircularProgressView()
        }
    }
}

extension View {
    func circularProgressViewModifier() -> some View {
        modifier(CircularProgressViewModifier())
    }
}

#Preview {
    EmptyView()
        .circularProgressViewModifier()
}

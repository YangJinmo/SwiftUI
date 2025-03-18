//
//  LoadingViewModifier.swift
//  Utils
//
//  Created by Jmy on 10/29/24.
//

import SwiftUI

struct LoadingViewModifier: ViewModifier {
    let isLoading: Bool
    let color: Color

    func body(content: Content) -> some View {
        ZStack {
            content

            if isLoading {
                CircularProgressView()
                    .backgroundViewModifier(color: color)
            }
        }
    }
}

extension View {
    func loadingViewModifier(isLoading: Bool, color: Color = .black.opacity(0.5)) -> some View {
        modifier(LoadingViewModifier(isLoading: isLoading, color: color))
    }
}

#Preview {
    EmptyView()
        .loadingViewModifier(isLoading: true)
}

//
//  ClearBackgroundModifier.swift
//  Utils
//
//  Created by Jmy on 2023/06/17.
//

import SwiftUI

struct ClearBackgroundModifier: ViewModifier {
    func body(content: Content) -> some View {
        if #available(iOS 16.0, *) {
            content
                .scrollContentBackground(.hidden)
        } else {
            content
                .onAppear {
                    UIScrollView.appearance().backgroundColor = .clear
                }
                .onDisappear {
                    UIScrollView.appearance().backgroundColor = nil
                }
        }
    }
}

extension View {
    func clearScrollBackground() -> some View {
        modifier(ClearBackgroundModifier())
    }
}

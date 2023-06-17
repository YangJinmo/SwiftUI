//
//  ListClearScrollContentBackgroundModifier.swift
//  Utils
//
//  Created by Jmy on 2023/06/17.
//

import SwiftUI

struct ListClearScrollContentBackgroundModifier: ViewModifier {
    func body(content: Content) -> some View {
        if #available(iOS 16.0, *) {
            content
                .scrollContentBackground(.hidden)
        } else {
            content
                .onAppear {
                    UITextView.appearance().backgroundColor = .clear
                }
                .onDisappear {
                    UITextView.appearance().backgroundColor = nil
                }
        }
    }
}

extension View {
    func clearScrollContentBackground() -> some View {
        modifier(ListClearScrollContentBackgroundModifier())
    }
}

//
//  OnDidLoadViewModifier.swift
//  Utils
//
//  Created by Jmy on 2023/08/31.
//

import SwiftUI

struct OnDidLoadViewModifier: ViewModifier {
    @State private var didLoad = false
    let action: (() -> Void)?

    func body(content: Content) -> some View {
        content
            .onAppear {
                if didLoad == false {
                    didLoad = true
                    action?()
                }
            }
    }
}

extension View {
    func onDidLoad(perform action: (() -> Void)? = nil) -> some View {
        modifier(OnDidLoadViewModifier(action: action))
    }
}

//
//  HeightPreferenceKey.swift
//  Utils
//
//  Created by Jmy on 2023/08/08.
//

import SwiftUI

struct HeightPreferenceKey: PreferenceKey {
    static var defaultValue: CGFloat = .zero

    static func reduce(value: inout CGFloat, nextValue: () -> CGFloat) {
        value = max(value, nextValue())
    }
}

extension View {
    // .readHeight { height in totalHeight = height }
    func readHeight(onChange: @escaping (CGFloat) -> Void) -> some View {
        background(
            GeometryReader { geometryProxy in
                Color.clear
                    .preference(key: HeightPreferenceKey.self, value: geometryProxy.size.height)
            }
        )
        .onPreferenceChange(HeightPreferenceKey.self, perform: onChange)
    }

    // .readHeight($totalHeight)
    func readHeight(_ binding: Binding<CGFloat>) -> some View {
        background(
            GeometryReader { geometry -> Color in
                let rect = geometry.frame(in: .local)

                DispatchQueue.main.async {
                    binding.wrappedValue = rect.size.height
                }

                return .clear
            }
        )
    }
}

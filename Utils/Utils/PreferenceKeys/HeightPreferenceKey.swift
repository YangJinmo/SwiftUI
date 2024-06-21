//
//  HeightPreferenceKey.swift
//  Utils
//
//  Created by Jmy on 2023/08/08.
//

import SwiftUI

struct HeightPreferenceKey: PreferenceKey {
    typealias Value = CGFloat

    static var defaultValue: Value = .zero

    static func reduce(value: inout Value, nextValue: () -> Value) {
        value = max(value, nextValue())
    }
}

extension View {
    // .readHeight { height in totalHeight = height }
    func readHeight(onChange: @escaping (CGFloat) -> Void) -> some View {
        background(
            GeometryReader { geometryProxy in
                Color.clear
                    .preference(key: HeightPreferenceKey.self, value: ceil(geometryProxy.size.height))
            }
        )
        .onPreferenceChange(HeightPreferenceKey.self, perform: onChange)
    }

    // .readHeight($totalHeight)
    func readHeight(_ binding: Binding<CGFloat>) -> some View {
        background(
            GeometryReader { geometryProxy -> Color in
                let rect = geometryProxy.frame(in: .local)

                DispatchQueue.main.async {
                    binding.wrappedValue = ceil(rect.size.height)
                }

                return .clear
            }
        )
    }
}

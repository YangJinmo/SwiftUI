//
//  WidthPreferenceKey.swift
//  Utils
//
//  Created by Jmy on 2023/08/21.
//

import SwiftUI

struct WidthPreferenceKey: PreferenceKey {
    typealias Value = CGFloat

    static var defaultValue: Value = .zero

    static func reduce(value: inout Value, nextValue: () -> Value) {
        value = max(value, nextValue())
    }
}

extension View {
    // .readWidth { height in totalWidth = width }
    func readWidth(onChange: @escaping (CGFloat) -> Void) -> some View {
        background(
            GeometryReader { geometryProxy in
                Color.clear
                    .preference(key: WidthPreferenceKey.self, value: ceil(geometryProxy.size.width))
            }
        )
        .onPreferenceChange(WidthPreferenceKey.self, perform: onChange)
    }

    // .readWidth($totalWidth)
    func readWidth(_ binding: Binding<CGFloat>) -> some View {
        background(
            GeometryReader { geometryProxy -> Color in
                let rect = geometryProxy.frame(in: .local)

                DispatchQueue.main.async {
                    binding.wrappedValue = ceil(rect.size.width)
                }

                return .clear
            }
        )
    }
}

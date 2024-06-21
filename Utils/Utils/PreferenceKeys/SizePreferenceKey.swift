//
//  SizePreferenceKey.swift
//  Utils
//
//  Created by Jmy on 2023/08/08.
//

import SwiftUI

struct SizePreferenceKey: PreferenceKey {
    typealias Value = CGSize

    static var defaultValue: Value = .zero

    static func reduce(value: inout Value, nextValue: () -> Value) {
        value.width = max(value.width, nextValue().width)
        value.height = max(value.height, nextValue().height)
    }
}

extension View {
    // .readSize { size in totalHeight = size.height }
    func readSize(onChange: @escaping (CGSize) -> Void) -> some View {
        background(
            GeometryReader { geometryProxy in
                Color.clear
                    .preference(key: SizePreferenceKey.self, value: CGSize(width: ceil(geometryProxy.size.width), height: ceil(geometryProxy.size.height)))
            }
        )
        .onPreferenceChange(SizePreferenceKey.self, perform: onChange)
    }

    // .readSize($totalSize)
    func readSize(_ binding: Binding<CGSize>) -> some View {
        background(
            GeometryReader { geometryProxy -> Color in
                let rect = geometryProxy.frame(in: .local)
                let size = CGSize(width: ceil(rect.width), height: ceil(rect.height))

                DispatchQueue.main.async {
                    binding.wrappedValue = size
                }

                return .clear
            }
        )
    }
}

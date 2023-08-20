//
//  SizePreferenceKey.swift
//  Utils
//
//  Created by Jmy on 2023/08/08.
//

import SwiftUI

struct SizePreferenceKey: PreferenceKey {
    typealias Size = CGSize

    static var defaultValue: Size = .zero

    static func reduce(value: inout Size, nextValue: () -> Size) {}
}

extension View {
    // .readSize { size in totalHeight = size.height }
    func readSize(onChange: @escaping (CGSize) -> Void) -> some View {
        background(
            GeometryReader { geometryProxy in
                Color.clear
                    .preference(key: SizePreferenceKey.self, value: geometryProxy.size)
            }
        )
        .onPreferenceChange(SizePreferenceKey.self, perform: onChange)
    }

    // .readSize($totalSize)
    func readSize(_ binding: Binding<CGSize>) -> some View {
        background(
            GeometryReader { geometry -> Color in
                let rect = geometry.frame(in: .local)

                DispatchQueue.main.async {
                    binding.wrappedValue = rect.size
                }

                return .clear
            }
        )
    }
}

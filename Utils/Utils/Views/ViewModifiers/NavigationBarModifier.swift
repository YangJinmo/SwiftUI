//
//  NavigationBarModifier.swift
//  Utils
//
//  Created by Jmy on 2023/06/29.
//

import SwiftUI

struct NavigationBarModifier<C, L, R>: ViewModifier where C: View, L: View, R: View {
    let centerView: (() -> C)?
    let leftView: (() -> L)?
    let rightView: (() -> R)?

    init(centerView: (() -> C)? = nil, leftView: (() -> L)? = nil, rightView: (() -> R)? = nil) {
        self.centerView = centerView
        self.leftView = leftView
        self.rightView = rightView
    }

    func body(content: Content) -> some View {
        GeometryReader { geometry in
            VStack {
                ZStack {
                    HStack {
                        self.leftView?()

                        Spacer()

                        self.rightView?()
                    }
                    .frame(height: 44.0)
                    .frame(maxWidth: .infinity)
                    .padding(.horizontal, 16.0)

                    HStack {
                        Spacer()

                        self.centerView?()

                        Spacer()
                    }
                    .foregroundColor(.gray100)
                    .frame(height: 44)
                    .padding([.leading, .trailing], 4)
                    .padding(.top, geometry.safeAreaInsets.top)
                }
                .foregroundColor(.gray100)
                .background(Color.gray800)
                .frame(width: geometry.size.width, height: 44 + geometry.safeAreaInsets.top)
                .ignoresSafeArea(.all, edges: .top)

                content

                Spacer()
            }
            .navigationBarHidden(true)
        }
    }
}

extension View {
    func navigationBar<C, L, R>(
        centerView: @escaping (() -> C),
        leftView: @escaping (() -> L),
        rightView: @escaping (() -> R)
    ) -> some View where C: View, L: View, R: View {
        modifier(
            NavigationBarModifier(centerView: centerView, leftView: leftView, rightView: rightView)
        )
    }

    func navigationBar<V>(
        centerView: @escaping (() -> V)
    ) -> some View where V: View {
        modifier(
            NavigationBarModifier(centerView: centerView, leftView: { EmptyView() }, rightView: { EmptyView() })
        )
    }
}

//
//  ViewRepresentable.swift
//  Utils
//
//  Created by Jmy on 2023/09/19.
//

import SwiftUI

struct ViewRepresentable<T: UIView>: UIViewRepresentable {
    let view: T

    init(_ viewBuilder: @escaping () -> T) {
        view = viewBuilder()
    }

    func makeUIView(context: Context) -> T {
        return view
    }

    func updateUIView(_ uiView: T, context: Context) {
    }
}

#Preview {
    ViewRepresentable {
        let view = UIView()
        view.backgroundColor = .systemGreen
        return view
    }
    .ignoresSafeArea()
}

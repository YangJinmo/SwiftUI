//
//  ViewControllerRepresentable.swift
//  Utils
//
//  Created by Jmy on 2023/09/19.
//

import SwiftUI

struct ViewControllerRepresentable<T: UIViewController>: UIViewControllerRepresentable {
    let viewController: T

    init(_ viewControllerBuilder: @escaping () -> T) {
        viewController = viewControllerBuilder()
    }

    func makeUIViewController(context: Context) -> T {
        return viewController
    }

    func updateUIViewController(_ uiViewController: T, context: Context) {
    }
}

#Preview {
    ViewControllerRepresentable {
        let viewController = UIViewController()
        viewController.view.backgroundColor = .systemGreen
        return viewController
    }
    .ignoresSafeArea()
}

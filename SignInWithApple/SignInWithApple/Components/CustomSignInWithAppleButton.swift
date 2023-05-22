//
//  CustomSignInWithAppleButton.swift
//  SignInWithApple
//
//  Created by Jmy on 2023/05/22.
//

import AuthenticationServices
import SwiftUI

struct CustomSignInWithAppleButton: UIViewRepresentable {
    func makeUIView(context: Context) -> UIButton {
        var titleAttr = AttributedString("Apple로 계속하기")
        titleAttr.font = .systemFont(ofSize: 20.0, weight: .bold)

        let imageConfiguration = UIImage.SymbolConfiguration(pointSize: 14.0)

        var buttonConfiguration = UIButton.Configuration.filled()
        buttonConfiguration.attributedTitle = titleAttr
        buttonConfiguration.image = UIImage(systemName: "apple.logo", withConfiguration: imageConfiguration)
        buttonConfiguration.imagePadding = 10
        buttonConfiguration.imagePlacement = .leading
        buttonConfiguration.baseBackgroundColor = .white
        buttonConfiguration.baseForegroundColor = .black
        buttonConfiguration.background.cornerRadius = 8

        let button = UIButton(configuration: buttonConfiguration)
        button.layer.borderWidth = 0.5
        button.layer.borderColor = UIColor.black.cgColor
        button.layer.cornerRadius = 8
        return button
    }

    func updateUIView(_ uiView: UIButton, context: Context) {
        // Nothing to update
    }
}

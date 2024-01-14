//
//  JMTextField.swift
//  Utils
//
//  Created by Jmy on 2023/07/15.
//

import SwiftUI

struct JMTextField: View {
    @Binding var text: String
    let placeholder: String

    @FocusState private var isFocused: Bool

    var body: some View {
        TextField(
            "",
            text: $text,
            prompt: promptText as? Text
        )
        .submitLabel(.next)
        .font(.subheadline2)
        .foregroundColor(.gray100)
        .clearButton(text: $text, isFocused: _isFocused)
        .padding(16)
        .background(Color.gray700)
        .cornerRadius(8)
        .overlay(
            RoundedRectangle(cornerRadius: 8)
                .strokeBorder(
                    isFocused
                        ? Color.accentColor
                        : Color.clear,
                    lineWidth: 1
                )
        )
        .focused($isFocused)
    }

    var promptText: some View {
        Text(placeholder)
            .foregroundColor(.gray300)
    }
}

#Preview {
    @State var productName = ""

    return JMTextField(text: $productName, placeholder: "상품을 입력해 주세요.")
        .padding()
}

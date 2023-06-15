//
//  TextFieldClearButtonViewModifier.swift
//  Utils
//
//  Created by Jmy on 2023/06/15.
//

import SwiftUI

struct TextFieldClearButtonViewModifier: ViewModifier {
    @Binding var text: String
    @FocusState var isFocused: Bool

    func body(content: Content) -> some View {
        HStack(spacing: 8) {
            content

            if !text.isEmpty, isFocused {
                Button {
                    text = ""
                } label: {
                    Image(systemName: "multiply.circle.fill")
                        .foregroundColor(.gray500)
                }
            }
        }
    }
}

extension View {
    func clearButton(text: Binding<String>, isFocused: FocusState<Bool>) -> some View {
        modifier(TextFieldClearButtonViewModifier(text: text, isFocused: isFocused))
    }
}

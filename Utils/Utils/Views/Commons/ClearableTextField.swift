//
//  ClearableTextField.swift
//  Utils
//
//  Created by Jmy on 2023/06/13.
//

import SwiftUI

struct ClearableTextField: View {
    @Binding var text: String
    @FocusState var isFocused: Bool

    var placeholder: String

    var body: some View {
        HStack(spacing: 8) {
            TextField(placeholder, text: $text)
                .focused($isFocused)

            if !text.isEmpty, isFocused {
                Button {
                    text = ""
                } label: {
                    Image.multiply_circle_fill
                        .foregroundColor(.gray500)
                }
            }
        }
    }
}

struct ClearableTextFieldView: View {
    @State private var text = ""
    @FocusState private var isFocused: Bool

    var body: some View {
        ClearableTextField(text: $text, isFocused: _isFocused, placeholder: "Placeholder")
    }
}

struct ClearableTextField_Previews: PreviewProvider {
    static var previews: some View {
        ClearableTextFieldView()
            .padding()
    }
}

//
//  JMTextEditor.swift
//  Utils
//
//  Created by Jmy on 2023/08/05.
//

import SwiftUI

struct JMTextEditor: View {
    @Binding var text: String
    let placeholder: String

    @FocusState private var isFocused: Bool

    var body: some View {
        ZStack(alignment: .topLeading) {
            TextEditor(text: $text)
                .clearScrollBackground()
                .padding(12)
                .background(Color.gray700)
                .cornerRadius(8)
                .frame(height: 160) // 160 5, 200 6
                .foregroundColor(.gray100)
                .focused($isFocused)
                .overlay(
                    RoundedRectangle(cornerRadius: 8)
                        .strokeBorder(
                            isFocused
                                ? Color.limeGreen
                                : Color.clear,
                            lineWidth: 1
                        )
                )

            if !isFocused, text.isEmpty {
                Text("내용을 자유롭게 작성해 주세요.")
                    .foregroundColor(.gray300)
                    .padding(16)
            }
        }
        .font(.subheadline2)
    }
}

struct JMTextEditor_Previews: PreviewProvider {
    @State private static var text = ""

    static var previews: some View {
        JMTextEditor(text: $text, placeholder: "텍스트를 입력해 주세요.")
    }
}

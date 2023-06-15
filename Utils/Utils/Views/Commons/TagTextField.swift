//
//  TagTextField.swift
//  Utils
//
//  Created by Jmy on 2023/06/15.
//

import SwiftUI

struct Tag: Identifiable, Equatable {
    let id = UUID()
    public var value: String = ""
}

struct TagTextField: View {
    @Binding var currentTag: Tag
    @Binding var focusTag: Tag?
    let onSubmit: (Tag) -> Void
    let xmarkTapped: (Tag) -> Void

    @FocusState private var isFocused: Bool

    var body: some View {
        HStack(spacing: 0) {
            Text("#")
                .font(.subheadline2)
                .foregroundColor(.gray100)

            TextField(
                "",
                text: $currentTag.value.max(6),
                prompt: promptText as? Text
            )
            .clearButton(text: $currentTag.value, isFocused: _isFocused)
            .font(.subheadline2)
            .foregroundColor(.gray100)
            .onChange(of: focusTag) { newValue in
                if let newValue = newValue {
                    isFocused = newValue == currentTag
                }
            }
            .focused($isFocused)
            .onChange(of: isFocused) { newValue in
                if newValue == false, !currentTag.value.isEmpty {
                    onSubmit(currentTag)
                }
            }
            .submitLabel(.next)
            .onSubmit {
                onSubmit(currentTag)
            }
            .disabled(!currentTag.value.isEmpty && !isFocused)

            if !currentTag.value.isEmpty, !isFocused {
                Button {
                    xmarkTapped(currentTag)
                } label: {
                    Image(systemName: "xmark")
                        .renderingMode(.template)
                        .foregroundColor(.gray500)
                        .frame(width: 18, height: 18)
                        .padding(.leading, 8)
                }
            }
        }
        .onTapGesture {
            isFocused = true
        }
        .padding(.horizontal, 16)
        .padding(.vertical, 8)
        .background(Color.gray700)
        .cornerRadius(8)
        .overlay(
            RoundedRectangle(cornerRadius: 8, style: .continuous)
                .strokeBorder(
                    isFocused
                        ? Color.limeGreen
                        : Color.clear,
                    lineWidth: 1
                )
        )
    }

    var promptText: some View {
        Text("태그")
            .foregroundColor(.gray300)
    }
}

extension Binding where Value == String {
    func max(_ limit: Int) -> Self {
        if wrappedValue.count > limit {
            DispatchQueue.main.async {
                wrappedValue = String(wrappedValue.dropLast())
            }
        }
        return self
    }
}

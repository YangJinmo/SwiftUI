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
                    Image.xmark
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

struct TagTextFieldPreview: View {
    @State private var subjects = [Tag()]
    @State private var focusSubject: Tag?

    @State private var actionTapped = false

    private func appendSubject() {
        if subjects.first(where: { $0.value.isEmpty }) == nil {
            subjects.append(Tag())
        }
    }

    var body: some View {
        ScrollView(.horizontal, showsIndicators: false) {
            HStack(spacing: 8) {
                ForEach($subjects) { $subject in
                    TagTextField(currentTag: $subject, focusTag: $focusSubject) { _ in
                        if subjects.count < 3 {
                            appendSubject()
                        }
                    } xmarkTapped: { subject in
                        subjects.removeAll { $0 == subject }
                        appendSubject()
                    }
                }
            }
            .padding()
        }
        .onChange(of: subjects) { _ in
            if !actionTapped {
                focusSubject = subjects.first { $0.value.isEmpty }
            }
        }
    }
}

#Preview {
    TagTextFieldPreview()
}

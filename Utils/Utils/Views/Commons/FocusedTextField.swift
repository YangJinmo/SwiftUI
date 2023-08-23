//
//  FocusedTextField.swift
//  Utils
//
//  Created by Jmy on 2023/08/06.
//

import SwiftUI

struct FocusedTextField: UIViewRepresentable {
    @Binding var text: String
    let isFirstResponder: Bool

    func makeUIView(context: UIViewRepresentableContext<FocusedTextField>) -> UITextField {
        let textField = UITextField(frame: .zero)
        textField.delegate = context.coordinator
        return textField
    }

    func updateUIView(_ uiView: UITextField, context: UIViewRepresentableContext<FocusedTextField>) {
        uiView.text = text

        if isFirstResponder {
            uiView.becomeFirstResponder()
        }
    }

    func makeCoordinator() -> FocusedTextField.Coordinator {
        return Coordinator(self)
    }

    class Coordinator: NSObject, UITextFieldDelegate {
        var parent: FocusedTextField

        init(_ parent: FocusedTextField) {
            self.parent = parent
        }

        func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
            if let currentText = textField.text, let textRange = Range(range, in: currentText) {
                let updatedText = currentText.replacingCharacters(in: textRange, with: string)
                parent.text = updatedText
            }
            return true
        }
    }
}

struct FocusedTextField_Previews: PreviewProvider {
    static var previews: some View {
        FocusedTextField_Previews_View()
    }
}

struct FocusedTextField_Previews_View: View {
    @State private var text = ""
    @State private var isEditing = true

    var body: some View {
        FocusedTextField(text: $text, isFirstResponder: isEditing)
            .frame(height: 44)
            .border(.red)
    }
}

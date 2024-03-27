//
//  UIViewRepresentableBootcamp.swift
//  Utils
//
//  Created by Jmy on 3/24/24.
//

import SwiftUI

// Convert a UIView from UIKit to SwiftUI
struct UIViewRepresentableBootcamp: View {
    @State private var text: String = ""

    var body: some View {
        Text(text)

        HStack {
            Text("SwiftUI: ")

            TextField("Type here...", text: $text)
                .frame(height: 55)
                .background(Color.gray)
        }

        HStack {
            Text("UIKit: ")

            UITextFieldViewRepresentable(text: $text)
                .frame(height: 55)
                .background(Color.gray)
        }
    }
}

#Preview {
    UIViewRepresentableBootcamp()
}

struct UITextFieldViewRepresentable: UIViewRepresentable {
    @Binding var text: String

    func makeUIView(context: Context) -> UITextField {
        let textField = getTextField()
        textField.delegate = context.coordinator
        return textField
    }

    // from SwiftUI to UIKit
    func updateUIView(_ uiView: UITextField, context: Context) {
        uiView.text = text
    }

    private func getTextField() -> UITextField {
        let textField = UITextField(frame: .zero)
        let placeholder = NSAttributedString(
            string: "Type here...",
            attributes: [
                .foregroundColor: UIColor.red,
            ]
        )
        textField.attributedPlaceholder = placeholder
        return textField
    }

    // from UIKit to SwiftUI
    func makeCoordinator() -> Coordinator {
        return Coordinator(text: $text)
    }

    class Coordinator: NSObject, UITextFieldDelegate {
        @Binding var text: String

        init(text: Binding<String>) {
            _text = text
        }

        func textFieldDidChangeSelection(_ textField: UITextField) {
            text = textField.text ?? ""
        }
    }
}

struct BasicUIViewRepresentable: UIViewRepresentable {
    func makeUIView(context: Context) -> some UIView {
        let view = UIView()
        view.backgroundColor = .red
        return view
    }

    func updateUIView(_ uiView: UIViewType, context: Context) {
    }
}

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
            UITextFieldViewRepresentable()
                .frame(height: 55)
                .background(Color.gray)
        }
    }
}

#Preview {
    UIViewRepresentableBootcamp()
}

struct UITextFieldViewRepresentable: UIViewRepresentable {
    func makeUIView(context: Context) -> some UIView {
        return getTextField()
    }

    func updateUIView(_ uiView: UIViewType, context: Context) {
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

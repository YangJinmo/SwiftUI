//
//  UIViewRepresentableBootcamp.swift
//  Utils
//
//  Created by Jmy on 3/24/24.
//

import SwiftUI

// Convert a UIView from UIKit to SwiftUI
struct UIViewRepresentableBootcamp: View {
    var body: some View {
        Text("Hello, World!")

        BasicUIViewRepresentable()
    }
}

#Preview {
    UIViewRepresentableBootcamp()
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

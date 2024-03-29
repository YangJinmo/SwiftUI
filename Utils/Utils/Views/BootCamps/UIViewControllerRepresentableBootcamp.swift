//
//  UIViewControllerRepresentableBootcamp.swift
//  Utils
//
//  Created by Jmy on 3/31/24.
//

import SwiftUI

struct UIViewControllerRepresentableBootcamp: View {
    @State private var showScreen: Bool = false

    var body: some View {
        VStack {
            Text("hi")

            Button(action: {
                showScreen.toggle()
            }, label: {
                Text("Click Here")
            })
            .sheet(isPresented: $showScreen, content: {
                BasicUIViewControllerRepresentable(labelText: "New text here")
            })
        }
    }
}

#Preview {
    UIViewControllerRepresentableBootcamp()
}

struct BasicUIViewControllerRepresentable: UIViewControllerRepresentable {
    let labelText: String

    func makeUIViewController(context: Context) -> some UIViewController {
        let vc = UIViewController()
        vc.view.backgroundColor = .blue

        let label = UILabel()
        label.text = labelText
        label.textColor = UIColor.white

        vc.view.addSubview(label)
        label.frame = vc.view.frame

        return vc
    }

    func updateUIViewController(_ uiViewController: UIViewControllerType, context: Context) {
    }
}

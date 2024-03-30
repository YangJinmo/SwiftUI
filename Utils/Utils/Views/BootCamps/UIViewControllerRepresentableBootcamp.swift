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
        let vc = MyFirstViewController()
        vc.labelText = labelText
        return vc
    }

    func updateUIViewController(_ uiViewController: UIViewControllerType, context: Context) {
    }
}

final class MyFirstViewController: UIViewController {
    var labelText: String = "Starting value"

    override func viewDidLoad() {
        super.viewDidLoad()

        view.backgroundColor = .blue

        let label = UILabel()
        label.text = labelText
        label.textColor = UIColor.white

        view.addSubview(label)
        label.frame = view.frame
    }
}

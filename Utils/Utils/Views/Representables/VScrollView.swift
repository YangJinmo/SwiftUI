//
//  VScrollView.swift
//  Utils
//
//  Created by Jmy on 2023/08/29.
//

import SwiftUI

struct VScrollView<Content: View>: UIViewRepresentable {
    typealias UIViewType = UIScrollView

    let content: Content

    init(@ViewBuilder content: () -> Content) {
        self.content = content()
    }

    func makeUIView(context: Context) -> UIScrollView {
        let scrollView = UIScrollView()
        scrollView.delegate = context.coordinator
        scrollView.isPagingEnabled = true
        scrollView.isDirectionalLockEnabled = true

        let child = UIHostingController(rootView: content)
        scrollView.addSubview(child.view)

        let size = child.view.sizeThatFits(CGSize(width: Screen.width, height: .greatestFiniteMagnitude))
        child.view.frame = CGRect(x: 0, y: 0, width: size.width, height: size.height)

        scrollView.contentSize = size
        return scrollView
    }

    func updateUIView(_ uiView: UIScrollView, context: Context) {
    }

    func makeCoordinator() -> Coordinator {
        return Coordinator(self)
    }

    class Coordinator: NSObject, UIScrollViewDelegate {
        var parent: VScrollView

        init(_ parent: VScrollView) {
            self.parent = parent
        }

        func scrollViewWillBeginDecelerating(_ scrollView: UIScrollView) {
        }
    }
}

struct VScrollViewPreview: View {
    var body: some View {
        GeometryReader { proxy in
            VScrollView {
                LazyVStack(spacing: 0) {
                    ForEach(0 ..< 10) {
                        Text("\($0)")
                            .frame(
                                width: proxy.size.width,
                                height: proxy.size.height
                            )
                            .border(.red)
                    }
                }
            }
        }
    }
}

#Preview {
    VScrollViewPreview()
}

struct Screen {
    static let width = UIScreen.main.bounds.width
    static let height = UIScreen.main.bounds.height
}

//
//  PagingScrollView.swift
//  Utils
//
//  Created by Jmy on 2023/08/27.
//

import SwiftUI

struct PagingScrollView<Content: View>: UIViewControllerRepresentable {
    var content: () -> Content

    init(@ViewBuilder content: @escaping () -> Content) {
        self.content = content
    }

    func makeUIViewController(context: Context) -> PagingScrollViewController {
        let vc = PagingScrollViewController()
        vc.hostingController.rootView = AnyView(content())
        return vc
    }

    func updateUIViewController(_ viewController: PagingScrollViewController, context: Context) {
        viewController.hostingController.rootView = AnyView(content())
    }
}

final class PagingScrollViewController: UIViewController {
    var hostingController: UIHostingController<AnyView> = UIHostingController(rootView: AnyView(EmptyView()))

    private lazy var scrollView: UIScrollView = {
        let scrollView = UIScrollView()
        scrollView.isPagingEnabled = true
        scrollView.isDirectionalLockEnabled = true
        return scrollView
    }()

    override func viewDidLoad() {
        super.viewDidLoad()

        view.addSubview(scrollView)
        pinEdges(of: scrollView, to: view)

        hostingController.willMove(toParent: self)
        scrollView.addSubview(hostingController.view)
        pinEdges(of: hostingController.view, to: scrollView)
        hostingController.didMove(toParent: self)
    }

    private func pinEdges(of viewA: UIView, to viewB: UIView) {
        viewA.translatesAutoresizingMaskIntoConstraints = false
        viewB.addConstraints([
            viewA.leadingAnchor.constraint(equalTo: viewB.leadingAnchor),
            viewA.trailingAnchor.constraint(equalTo: viewB.trailingAnchor),
            viewA.topAnchor.constraint(equalTo: viewB.topAnchor),
            viewA.bottomAnchor.constraint(equalTo: viewB.bottomAnchor),
        ])
    }
}

struct PagingScrollViewPreview: View {
    var body: some View {
        GeometryReader { proxy in
            PagingScrollView {
                LazyVStack(spacing: 0) {
                    ForEach(0 ..< 10) { i in
                        LazyHStack(spacing: 0) {
                            ForEach(0 ..< 10) { j in
                                Text("(\(i), \(j))")
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
    }
}

struct PagingScrollViewPreview_Previews: PreviewProvider {
    static var previews: some View {
        PagingScrollViewPreview()
    }
}

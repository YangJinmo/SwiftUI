//
//  CollectionView.swift
//  Utils
//
//  Created by Jmy on 2023/09/18.
//

import SwiftUI

struct CollectionView: UIViewRepresentable {
    // struct CollectionView<Content: View>: UIViewRepresentable {
    typealias UIViewType = UICollectionView

    // UICollectionViewDataSource
    var items = [Any]()

    // UICollectionViewDelegateFlowLayout
    var itemSize = CGSize(width: UIScreen.main.bounds.width, height: UIScreen.main.bounds.height)

    @ObservedObject var service: CollectionViewService

//    let content: Content
//
//    init(@ViewBuilder content: () -> Content) {
//        self.content = content()
//    }
    private let reuseIdentifier = "CollectionViewCell"

    func makeUIView(context: Context) -> UIViewType {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = service.scrollDirection
        layout.sectionInset = service.sectionInset
        layout.minimumLineSpacing = service.minimumLineSpacing
        layout.minimumInteritemSpacing = service.minimumInteritemSpacing

        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collectionView.isPagingEnabled = service.isPagingEnabled
        collectionView.backgroundColor = .systemBackground

        collectionView.register(UICollectionViewCell.self, forCellWithReuseIdentifier: reuseIdentifier)

        collectionView.dataSource = context.coordinator
        collectionView.delegate = context.coordinator

        return collectionView
    }

    func updateUIView(_ uiView: UIViewType, context: Context) {
    }

    func makeCoordinator() -> Coordinator {
        Coordinator(self)
    }

    class Coordinator: NSObject, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout, UICollectionViewDelegate {
        let parent: CollectionView

        init(_ collectionView: CollectionView) {
            parent = collectionView
        }

        // UICollectionViewDataSource
        func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
            parent.items.count
        }

        func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: parent.reuseIdentifier, for: indexPath)
            cell.backgroundColor = .black

            let item = parent.items[indexPath.item] as! String
            let url = item.toURL!
            let swiftUIContent = {
//                HStack {
//                    Image(systemName: "star")
//                        .foregroundColor(.purple)
//
//                    Text("Favorites")
//
//                    Spacer() // A spacer to left align the 2 views above
//                }

                LoopingVideoPlayer(url: url)
            }

            if #available(iOS 16.0, *) {
                cell.contentConfiguration = UIHostingConfiguration(content: swiftUIContent)
            } else {
                cell.contentConfiguration = HostingContentConfiguration {
                    // We add a little bit of padding & height to match the UIHostingConfiguration
                    swiftUIContent()
//                        .padding()
//                        .frame(height: 44)
                }
            }

            return cell
        }

        // UICollectionViewDelegateFlowLayout
        func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
            return parent.itemSize
        }

        // UICollectionViewDelegate
        func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
            parent.service.indexPath = indexPath
        }
    }
}

struct CollectionViewPreview: View {
    @StateObject private var collectionViewService = CollectionViewService(
        scrollDirection: .horizontal,
        minimumLineSpacing: .zero,
        minimumInteritemSpacing: .zero,
        isPagingEnabled: true
    )

    private let items = [
        "https://bitdash-a.akamaihd.net/content/MI201109210084_1/m3u8s/f08e80da-bf1d-4e3d-8899-f0f6155f6efa.m3u8",
        "https://bitdash-a.akamaihd.net/content/MI201109210084_1/m3u8s/f08e80da-bf1d-4e3d-8899-f0f6155f6efa.m3u8",
        "https://bitdash-a.akamaihd.net/content/MI201109210084_1/m3u8s/f08e80da-bf1d-4e3d-8899-f0f6155f6efa.m3u8",
        "https://bitdash-a.akamaihd.net/content/MI201109210084_1/m3u8s/f08e80da-bf1d-4e3d-8899-f0f6155f6efa.m3u8",
        "https://bitdash-a.akamaihd.net/content/MI201109210084_1/m3u8s/f08e80da-bf1d-4e3d-8899-f0f6155f6efa.m3u8",
        "https://bitdash-a.akamaihd.net/content/MI201109210084_1/m3u8s/f08e80da-bf1d-4e3d-8899-f0f6155f6efa.m3u8",
    ]

    var body: some View {
        GeometryReader { proxy in
            CollectionView(
                items: items,
                itemSize: CGSize(width: proxy.size.width, height: proxy.size.height),
                service: collectionViewService
            )
        }
        .ignoresSafeArea()
    }
}

struct CollectionViewRepresentable_Previews: PreviewProvider {
    static var previews: some View {
        CollectionViewPreview()
    }
}

struct HostingContentConfiguration<Content>: UIContentConfiguration where Content: View {
    // fileprivate, since we'll put ContentView that will be expained in the next code block in the same file
    fileprivate let hostingController: UIHostingController<Content>

    init(@ViewBuilder content: () -> Content) {
        hostingController = UIHostingController(rootView: content())
    }

    func makeContentView() -> UIView & UIContentView {
        // Our custom UIView that conforms to UIContentView
        ContentView<Content>(self)
    }

    func updated(for state: UIConfigurationState) -> HostingContentConfiguration<Content> {
        self
    }
}

private class ContentView<Content>: UIView, UIContentView where Content: View {
    var configuration: UIContentConfiguration {
        didSet {
            // (Re)configure once we have have a configuration
            configure(configuration)
        }
    }

    init(_ configuration: UIContentConfiguration) {
        self.configuration = configuration

        super.init(frame: .zero)
    }

    required init?(coder: NSCoder) {
        // This view shouldn't be initialized this way so we crash
        fatalError("init(coder:) has not been implemented")
    }

    private func configure(_ configuration: UIContentConfiguration) {
        guard let configuration = configuration as? HostingContentConfiguration<Content>,
              let parent = findViewController() else {
            return
        }

        let hostingController = configuration.hostingController

        guard let swiftUICellView = hostingController.view,
              subviews.isEmpty else {
            hostingController.view.invalidateIntrinsicContentSize()
            return
        }

        // A clear background since that's all we need for now
        hostingController.view.backgroundColor = .clear

        parent.addChild(hostingController)
        addSubview(hostingController.view)
        hostingController.view.translatesAutoresizingMaskIntoConstraints = false

        let constraints = [
            leadingAnchor.constraint(equalTo: swiftUICellView.leadingAnchor),
            trailingAnchor.constraint(equalTo: swiftUICellView.trailingAnchor),
            topAnchor.constraint(equalTo: swiftUICellView.topAnchor),
            bottomAnchor.constraint(equalTo: swiftUICellView.bottomAnchor),
        ]

        NSLayoutConstraint.activate(constraints)
        hostingController.didMove(toParent: parent)
    }
}

extension UIView {
    func findViewController() -> UIViewController? {
        if let nextResponder = next as? UIViewController {
            return nextResponder
        } else if let nextResponder = next as? UIView {
            return nextResponder.findViewController()
        }

        return nil
    }
}

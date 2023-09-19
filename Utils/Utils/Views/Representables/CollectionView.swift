//
//  CollectionView.swift
//  Utils
//
//  Created by Jmy on 2023/09/18.
//

import SwiftUI

struct CollectionView: UIViewRepresentable {
    typealias UIViewType = UICollectionView

    // UICollectionViewDataSource
    var items = [Any]()

    // UICollectionViewDelegateFlowLayout
    var itemSize = CGSize(width: UIScreen.main.bounds.width, height: UIScreen.main.bounds.height)

    @ObservedObject var service: CollectionViewService

    func makeUIView(context: Context) -> UIViewType {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = service.scrollDirection
        layout.sectionInset = service.sectionInset
        layout.minimumLineSpacing = service.minimumLineSpacing
        layout.minimumInteritemSpacing = service.minimumInteritemSpacing

        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collectionView.backgroundColor = .systemBackground
        collectionView.register(UICollectionViewCell.self, forCellWithReuseIdentifier: "Cell")
        collectionView.isPagingEnabled = service.isPagingEnabled

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
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "Cell", for: indexPath)
            cell.backgroundColor = .systemYellow
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
        minimumLineSpacing: 1,
        minimumInteritemSpacing: 20,
        isPagingEnabled: true
    )

    var body: some View {
        GeometryReader { proxy in
            CollectionView(
                items: Array(0 ... 100),
                itemSize: CGSize(width: proxy.size.width - 1, height: proxy.size.height),
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

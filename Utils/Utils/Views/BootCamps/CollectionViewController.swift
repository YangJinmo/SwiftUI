//
//  CollectionViewController.swift
//  Utils
//
//  Created by Jmy on 2023/09/26.
//

import UIKit

final class CollectionViewController: UICollectionViewController, UICollectionViewDelegateFlowLayout {
    init() {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .vertical
        layout.sectionInset = .zero
        layout.minimumLineSpacing = .zero
        layout.minimumInteritemSpacing = .zero

        super.init(collectionViewLayout: layout)
    }

    init(
        scrollDirection: UICollectionView.ScrollDirection = .vertical,
        sectionInset: UIEdgeInsets = .zero,
        minimumLineSpacing: CGFloat = .zero,
        minimumInteritemSpacing: CGFloat = .zero
    ) {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = scrollDirection
        layout.sectionInset = sectionInset
        layout.minimumLineSpacing = minimumLineSpacing
        layout.minimumInteritemSpacing = minimumInteritemSpacing

        super.init(collectionViewLayout: layout)
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func viewDidLoad() {
        super.viewDidLoad()

        collectionView.showsVerticalScrollIndicator = false
        collectionView.showsHorizontalScrollIndicator = false
        collectionView.isPagingEnabled = true
        collectionView.register(MyCollectionViewCell.self, forCellWithReuseIdentifier: MyCollectionViewCell.reuseIdentifier)
        collectionView.dataSource = self
        collectionView.delegate = self

        if let top = UIApplication.sharedKeyWindow?.safeAreaInsets.top {
            collectionView.contentInset.top = -top
        }
    }

    // UICollectionViewDataSource

    override func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }

    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 300
    }

    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: MyCollectionViewCell.reuseIdentifier, for: indexPath) as? MyCollectionViewCell else {
            fatalError("Could not dequeue cell")
        }

        return cell
    }

    // UICollectionViewDelegateFlowLayout

    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: collectionView.bounds.width, height: collectionView.bounds.height)
    }

    // UICollectionViewDelegate

    override func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        print("indexPath: \(String(describing: indexPath))")
    }
}

import SwiftUI

#Preview {
    ViewControllerRepresentable {
        CollectionViewController()
    }
    .ignoresSafeArea()
}

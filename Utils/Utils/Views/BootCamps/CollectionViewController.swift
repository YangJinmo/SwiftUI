//
//  CollectionViewController.swift
//  Utils
//
//  Created by Jmy on 2023/09/26.
//

import UIKit

class CollectionViewController: UICollectionViewController {
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
}

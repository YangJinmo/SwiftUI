//
//  CollectionViewService.swift
//  Utils
//
//  Created by Jmy on 2023/09/19.
//

import Combine
import UIKit

final class CollectionViewService: ObservableObject {
    // UICollectionViewFlowLayout
    @Published var scrollDirection = UICollectionView.ScrollDirection.vertical
    @Published var numberOfItemForRow = CGFloat(1)
    @Published var sectionInset = UIEdgeInsets.zero
    @Published var minimumLineSpacing = CGFloat.zero
    @Published var minimumInteritemSpacing = CGFloat.zero

    // UICollectionView
    @Published var isPagingEnabled = false

    // UICollectionViewDelegate
    @Published var indexPath: IndexPath?

    var cancellables: Set<AnyCancellable> = []

    init(
        scrollDirection: UICollectionView.ScrollDirection = .vertical,
        numberOfItemForRow: CGFloat = 1,
        sectionInset: UIEdgeInsets = .zero,
        minimumLineSpacing: CGFloat = .zero,
        minimumInteritemSpacing: CGFloat = .zero,
        isPagingEnabled: Bool = false
    ) {
        self.scrollDirection = scrollDirection
        self.numberOfItemForRow = numberOfItemForRow
        self.sectionInset = sectionInset
        self.minimumLineSpacing = minimumLineSpacing
        self.minimumInteritemSpacing = minimumInteritemSpacing
        self.isPagingEnabled = isPagingEnabled

        // configureDidSelectItemAt()
    }

    private func configureDidSelectItemAt() {
        $indexPath
            .sink { indexPath in
                self.didSelectItemAt(indexPath: indexPath ?? IndexPath())
            }
            .store(in: &cancellables)
    }

    private func didSelectItemAt(indexPath: IndexPath) {
        print("indexPath: \(String(describing: indexPath))")
    }
}

//
//  AnyCollectionViewController.swift
//  Utils
//
//  Created by Jmy on 2023/10/29.
//

import UIKit

final class AnyCollectionViewController: CollectionViewController {
    private var items: [Any] = []

    convenience init(items: [Any]) {
        self.init()

        self.items = items
    }

    override func viewDidLoad() {
        super.viewDidLoad()

        collectionView.showsVerticalScrollIndicator = false
        collectionView.showsHorizontalScrollIndicator = false
        collectionView.isPagingEnabled = true

        collectionView.register(MyCollectionViewCell.self, forCellWithReuseIdentifier: MyCollectionViewCell.reuseIdentifier)
        collectionView.dataSource = self
        collectionView.delegate = self

//        if let top = UIApplication.sharedKeyWindow?.safeAreaInsets.top {
//            collectionView.contentInset.top = -top
//        }
    }
}

// MARK: UICollectionViewDelegateFlowLayout

extension AnyCollectionViewController: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: collectionView.bounds.width, height: collectionView.bounds.height)
    }
}

// MARK: UICollectionViewDataSource

extension AnyCollectionViewController {
    override func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }

    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return items.count
    }

    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: MyCollectionViewCell.reuseIdentifier, for: indexPath) as? MyCollectionViewCell else {
            fatalError("Could not dequeue cell")
        }

        let item = items[indexPath.item]
        let label = UILabel()
        label.text = "\(item)"
        label.backgroundColor = .systemBlue
        label.translatesAutoresizingMaskIntoConstraints = false

        cell.contentView.addSubview(label)

        NSLayoutConstraint.activate([
            label.topAnchor.constraint(equalTo: cell.contentView.topAnchor),
            label.bottomAnchor.constraint(equalTo: cell.contentView.bottomAnchor),
            label.leadingAnchor.constraint(equalTo: cell.contentView.leadingAnchor),
            label.trailingAnchor.constraint(equalTo: cell.contentView.trailingAnchor),
            // label.centerXAnchor.constraint(equalTo: cell.contentView.centerXAnchor),
            // label.centerYAnchor.constraint(equalTo: cell.contentView.centerYAnchor),
        ])

        // cell.configure(with: item, parent: self)

        return cell
    }
}

// MARK: UICollectionViewDelegate

extension AnyCollectionViewController {
    override func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        print("indexPath: \(String(describing: indexPath))")
    }
}

import SwiftUI

struct AnyCollectionViewController_Previews: PreviewProvider {
    static var previews: some View {
        ViewControllerRepresentable {
            // CollectionViewController()
            AnyCollectionViewController(items: ["1", "2"])
        }
        .ignoresSafeArea()
    }
}

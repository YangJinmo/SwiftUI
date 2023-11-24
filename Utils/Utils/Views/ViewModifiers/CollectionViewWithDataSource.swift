//
//  CollectionViewWithDataSource.swift
//  Utils
//
//  Created by Jmy on 2023/11/22.
//

import SwiftUI
import UIKit

final class CollectionViewWithDataSource<SectionIdentifierType, ItemIdentifierType>: UICollectionView where SectionIdentifierType: Hashable & Sendable, ItemIdentifierType: Hashable & Sendable {
    typealias DataSource = UICollectionViewDiffableDataSource<SectionIdentifierType, ItemIdentifierType>
    typealias Snapshot = NSDiffableDataSourceSnapshot<SectionIdentifierType, ItemIdentifierType>

    private let cellProvider: DataSource.CellProvider

    private let updateQueue: DispatchQueue = DispatchQueue(
        label: "com.collectionview.update",
        qos: .userInteractive)

    private lazy var collectionDataSource: DataSource = {
        DataSource(
            collectionView: self,
            cellProvider: cellProvider
        )
    }()

    init(
        frame: CGRect,
        collectionViewLayout: UICollectionViewLayout,
        collectionViewConfiguration: (UICollectionView) -> Void,
        cellProvider: @escaping DataSource.CellProvider,
        supplementaryViewProvider: DataSource.SupplementaryViewProvider?
    ) {
        self.cellProvider = cellProvider

        super.init(frame: frame, collectionViewLayout: collectionViewLayout)

        collectionViewConfiguration(self)

        collectionDataSource.supplementaryViewProvider = supplementaryViewProvider
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    func apply(
        _ snapshot: Snapshot,
        animatingDifferences: Bool = true,
        completion: (() -> Void)? = nil
    ) {
        updateQueue.async { [weak self] in
            self?.collectionDataSource.apply(
                snapshot,
                animatingDifferences: animatingDifferences,
                completion: completion
            )
        }
    }
}

extension CollectionView2 {
    typealias UIKitCollectionView = CollectionViewWithDataSource<SectionIdentifierType, ItemIdentifierType>
    typealias DataSource = UICollectionViewDiffableDataSource<SectionIdentifierType, ItemIdentifierType>
    typealias Snapshot = NSDiffableDataSourceSnapshot<SectionIdentifierType, ItemIdentifierType>
    typealias UpdateCompletion = () -> Void
}

struct CollectionView2<SectionIdentifierType, ItemIdentifierType> where SectionIdentifierType: Hashable & Sendable, ItemIdentifierType: Hashable & Sendable {
    private let snapshot: Snapshot
    private let configuration: (UICollectionView) -> Void
    private let cellProvider: DataSource.CellProvider
    private let supplementaryViewProvider: DataSource.SupplementaryViewProvider?

    private let collectionViewLayout: () -> UICollectionViewLayout

    private(set) var collectionViewDelegate: (() -> UICollectionViewDelegate)?
    private(set) var animatingDifferences: Bool = true
    private(set) var updateCallBack: UpdateCompletion?

    init(
        snapshot: Snapshot,
        collectionViewLayout: @escaping () -> UICollectionViewLayout,
        configuration: @escaping ((UICollectionView) -> Void) = { _ in },
        cellProvider: @escaping DataSource.CellProvider,
        supplementaryViewProvider: DataSource.SupplementaryViewProvider? = nil
    ) {
        self.snapshot = snapshot
        self.configuration = configuration
        self.cellProvider = cellProvider
        self.supplementaryViewProvider = supplementaryViewProvider
        self.collectionViewLayout = collectionViewLayout
    }
}

extension CollectionView2: UIViewRepresentable {
    func makeUIView(context: Context) -> UIKitCollectionView {
        let collectionView = UIKitCollectionView(
            frame: .zero,
            collectionViewLayout: collectionViewLayout(),
            collectionViewConfiguration: configuration,
            cellProvider: cellProvider,
            supplementaryViewProvider: supplementaryViewProvider
        )

        let delegate = collectionViewDelegate?()
        collectionView.delegate = delegate
        return collectionView
    }

    func updateUIView(
        _ uiView: UIKitCollectionView,
        context: Context
    ) {
        uiView.apply(
            snapshot,
            animatingDifferences: animatingDifferences,
            completion: updateCallBack
        )
    }
}

extension CollectionView2 {
    func animateDifferences(_ animate: Bool) -> Self {
        var selfCopy = self
        selfCopy.animatingDifferences = animate
        return self
    }

    func onUpdate(_ perform: (() -> Void)?) -> Self {
        var selfCopy = self
        selfCopy.updateCallBack = perform
        return self
    }

    func collectionViewDelegate(_ makeDelegate: @escaping (() -> UICollectionViewDelegate)) -> Self {
        var selfCopy = self
        selfCopy.collectionViewDelegate = makeDelegate
        return self
    }
}

final class CollectionViewDelegateProxy: NSObject, UICollectionViewDelegate {
    let didScroll: (UIScrollView) -> Void
    let didSelect: (UICollectionView, IndexPath) -> Void

    init(
        didScroll: @escaping (UIScrollView) -> Void,
        didSelect: @escaping (UICollectionView, IndexPath) -> Void
    ) {
        self.didScroll = didScroll
        self.didSelect = didSelect
    }

    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        didScroll(scrollView)
    }

    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        didSelect(collectionView, indexPath)
    }
}

struct ContentView2: View {
    typealias Item = Int
    typealias Section = Int
    typealias Snapshot = NSDiffableDataSourceSnapshot<Section, Item>

    @State var snapshot: Snapshot = {
        var initialSnapshot = Snapshot()
        initialSnapshot.appendSections([0])
        return initialSnapshot
    }()

    var body: some View {
        ZStack(alignment: .bottom) {
            CollectionView2(
                snapshot: snapshot,
                collectionViewLayout: collectionViewLayout,
                configuration: collectionViewConfiguration,
                cellProvider: cellProvider,
                supplementaryViewProvider: supplementaryProvider
            )
            .padding()

            Button(
                action: {
                    let itemsCount = snapshot.numberOfItems(inSection: 0)
                    snapshot.appendItems([itemsCount + 1], toSection: 0)
                }, label: {
                    Text("Add More Items")
                }
            )
        }
    }
}

extension ContentView2 {
    func collectionViewLayout() -> UICollectionViewLayout {
        UICollectionViewFlowLayout()
    }

    func collectionViewConfiguration(_ collectionView: UICollectionView) {
        collectionView.register(
            UICollectionViewCell.self,
            forCellWithReuseIdentifier: "CellReuseId"
        )

        collectionView.register(
            UICollectionReusableView.self,
            forSupplementaryViewOfKind: "KindOfHeader",
            withReuseIdentifier: "SupplementaryReuseId"
        )
    }

    func cellProvider(
        _ collectionView: UICollectionView,
        indexPath: IndexPath,
        item: Item
    ) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(
            withReuseIdentifier: "CellReuseId",
            for: indexPath
        )

        cell.backgroundColor = .red
        return cell
    }

    func supplementaryProvider(
        _ collectionView: UICollectionView,
        elementKind: String,
        indexPath: IndexPath
    ) -> UICollectionReusableView {
        collectionView.dequeueReusableSupplementaryView(
            ofKind: elementKind,
            withReuseIdentifier: "SupplementaryReuseId",
            for: indexPath
        )
    }
}

extension UICollectionView.CellRegistration {
    static func hosting<Content: View, GenericItem>(
        content: @escaping (IndexPath, GenericItem) -> Content
    ) -> UICollectionView.CellRegistration<UICollectionViewCell, GenericItem> {
        UICollectionView.CellRegistration { cell, indexPath, item in
            if #available(iOS 16.0, *) {
                cell.contentConfiguration = UIHostingConfiguration {
                    content(indexPath, item)
                }
            } else {
                cell.contentConfiguration = HostingContentConfiguration {
                    content(indexPath, item)
                }
            }
        }
    }
}

extension ContentView3 {
    func collectionViewLayout() -> UICollectionViewLayout {
        UICollectionViewFlowLayout()
    }

    func cellProviderWithRegistration(
        _ collectionView: UICollectionView,
        indexPath: IndexPath,
        item: Item
    ) -> UICollectionViewCell {
        collectionView.dequeueConfiguredReusableCell(
            using: cellRegistration,
            for: indexPath,
            item: item
        )
    }
}

struct ContentView3: View {
    typealias Item = Int
    typealias Section = Int
    typealias Snapshot = NSDiffableDataSourceSnapshot<Section, Item>

    @State private var snapshot: Snapshot = {
        var initialSnapshot = Snapshot()
        initialSnapshot.appendSections([0])
        return initialSnapshot
    }()

    var body: some View {
        ZStack(alignment: .bottom) {
            CollectionView2(
                snapshot: snapshot,
                collectionViewLayout: collectionViewLayout,
                cellProvider: cellProviderWithRegistration
            )
            .padding()

            Button(
                action: {
                    let itemsCount = snapshot.numberOfItems(inSection: 0)
                    snapshot.appendItems([itemsCount + 1], toSection: 0)
                }, label: {
                    Text("Add More Items")
                }
            )
        }
    }

    let cellRegistration: UICollectionView.CellRegistration = .hosting { (_: IndexPath, item: Item) in
        Text("\(item)")
    }
}

struct ContentView2_Previews: PreviewProvider {
    static var previews: some View {
        ContentView2()
    }
}

struct ContentView3_Previews: PreviewProvider {
    static var previews: some View {
        ContentView3()
    }
}

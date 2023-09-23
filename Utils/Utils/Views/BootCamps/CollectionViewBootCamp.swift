//
//  CollectionViewBootCamp.swift
//  Utils
//
//  Created by Jmy on 2023/09/23.
//

import SwiftUI
import UIKit

final class CollectionViewBootCamp: UIViewController {
    private lazy var logo: UIImageView = {
        let imageView = UIImageView()
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.contentMode = .scaleAspectFit
        imageView.image = UIImage(systemName: "photo.artframe") // UIImage(imageLiteralResourceName: "VrboLogo")
        return imageView
    }()

    private lazy var label: UILabel = {
        let label = UILabel()
        label.font = UIFont.boldSystemFont(ofSize: 24.0)
        label.text = "Find spaces that suit your style"
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()

    private lazy var collectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .horizontal
        layout.sectionInset = UIEdgeInsets(top: 16, left: 16, bottom: 16, right: 16)
        layout.minimumLineSpacing = 16
        layout.minimumInteritemSpacing = 16

        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collectionView.backgroundColor = UIColor(named: "Light")
        collectionView.dataSource = self
        collectionView.delegate = self
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        collectionView.register(MyCollectionViewCell.self, forCellWithReuseIdentifier: MyCollectionViewCell.reuseIdentifier)
        return collectionView
    }()

    override func viewDidLoad() {
        super.viewDidLoad()

        setupView()
    }

    private func setupView() {
        view.addSubview(logo)
        view.addSubview(label)
        view.addSubview(collectionView)

        NSLayoutConstraint.activate([
            logo.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            logo.topAnchor.constraint(equalTo: view.topAnchor),

            label.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 16),
            label.topAnchor.constraint(equalTo: logo.bottomAnchor, constant: 32),
            label.heightAnchor.constraint(equalToConstant: 24),

            collectionView.topAnchor.constraint(equalTo: label.bottomAnchor),
            collectionView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            collectionView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            collectionView.heightAnchor.constraint(equalToConstant: 320 + 16 + 16),
        ])
    }
}

extension CollectionViewBootCamp: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 9
    }

    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: MyCollectionViewCell.reuseIdentifier, for: indexPath) as? MyCollectionViewCell else {
            fatalError("Could not dequeue cell")
        }
        cell.embed(in: self)
        return cell
    }
}

extension CollectionViewBootCamp: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: 240, height: 320)
    }
}

struct CollectionViewBootCamp_Previews: PreviewProvider {
    static var previews: some View {
        ViewControllerRepresentable {
            CollectionViewBootCamp()
        }
    }
}

import SwiftUI
import UIKit

final class MyCollectionViewCell: UICollectionViewCell {
    static var reuseIdentifier = "MyCollectionViewCell"

    lazy var host: UIHostingController = {
        UIHostingController(rootView: Card())
    }()

    override init(frame: CGRect) {
        super.init(frame: frame)

        setupView()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    private func setupView() {
        host.view.translatesAutoresizingMaskIntoConstraints = false
        contentView.addSubview(host.view)

        NSLayoutConstraint.activate([
            host.view.topAnchor.constraint(equalTo: contentView.topAnchor),
            host.view.bottomAnchor.constraint(equalTo: contentView.bottomAnchor),
            host.view.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
            host.view.trailingAnchor.constraint(equalTo: contentView.trailingAnchor),
        ])
    }

    func embed(in parent: UIViewController) {
        parent.addChild(host)
        host.didMove(toParent: parent)
        print("MyCollectionViewCell has been added to parent UIViewController")
    }

    deinit {
        host.willMove(toParent: nil)
        host.view.removeFromSuperview()
        host.removeFromParent()
        print("MyCollectionViewCell has been cleaned up")
    }
}

struct Card: View {
    var body: some View {
        VStack(alignment: .leading, spacing: 8) {
            Image(systemName: "photo.artframe")
                .resizable()
                .clipShape(RoundedRectangle(cornerRadius: 4))

            Text("Condo with awesome views of downtown")
                .font(.headline)

            Text("$42 avg/night")
                .font(.body)
                .lineLimit(1)
        }
    }
}

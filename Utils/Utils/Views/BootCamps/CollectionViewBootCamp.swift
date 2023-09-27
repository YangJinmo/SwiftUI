//
//  CollectionViewBootCamp.swift
//  Utils
//
//  Created by Jmy on 2023/09/23.
//

import SwiftUI
import UIKit

final class CollectionViewBootCamp: UIViewController {
    // MARK: Data

    struct Item: MyCollectionViewCell.Content {
        var id: String
        var imageName: String
        var title: String
        var description: String
    }

    let items: [Item] = [
        Item(id: UUID().uuidString, imageName: "condos", title: "Condo with awesome views of downtown", description: "$117 avg/night"),
        Item(id: UUID().uuidString, imageName: "houses", title: "Oceanfront 3 BR/3 BA", description: "$400 avg/night"),
        Item(id: UUID().uuidString, imageName: "studios", title: "Art Studio", description: "$65 avg/night"),
        Item(id: UUID().uuidString, imageName: "villas", title: "Luxury 4 BR/3 BA Villa", description: "$109 avg/night"),
        Item(id: UUID().uuidString, imageName: "cabins", title: "Cabin in the Pike", description: "$200 avg/night"),
        Item(id: UUID().uuidString, imageName: "bungalows", title: "Cottage on Ocean Bluff", description: "$159 avg/night"),
        Item(id: UUID().uuidString, imageName: "resorts", title: "Terranea Oceanside King Casita", description: "$351 avg/night"),
        Item(id: UUID().uuidString, imageName: "chalets", title: "Romantic Mountain Chalet", description: "$104 avg/night"),
        Item(id: UUID().uuidString, imageName: "farmhouses", title: "Cozy Farmhouse on 10 Acres", description: "$199 avg/night"),
    ]

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
        return items.count
    }

    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: MyCollectionViewCell.reuseIdentifier, for: indexPath) as? MyCollectionViewCell else {
            fatalError("Could not dequeue cell")
        }

        let item = items[indexPath.row]
        cell.configure(with: item, parent: self)

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

class MyCollectionViewCell: SwiftUICollectionViewCell<Card> {
    static var reuseIdentifier = "MyCollectionViewCell"

    typealias Content = Card.Content

    func configure(with content: Content, parent: UIViewController) {
        embed(in: parent, withView: Card(content: content))
        host?.view.frame = contentView.bounds
    }
}

import SwiftUI
import UIKit

/// Subclass for embedding a SwiftUI View inside of UICollectionViewCell
/// Usage: `class MySwiftUICell: SwiftUICollectionViewCell<Card> { ... }`
open class SwiftUICollectionViewCell<Content>: UICollectionViewCell where Content: View {
    /// Controller to host the SwiftUI View
    private(set) var host: UIHostingController<Content>?

    /// Add host controller to the heirarchy
    func embed(in parent: UIViewController, withView content: Content) {
        if let host = host {
            host.rootView = content
            host.view.layoutIfNeeded()
        } else {
            let host = UIHostingController(rootView: content)

            parent.addChild(host)
            host.didMove(toParent: parent)
            contentView.addSubview(host.view)
            self.host = host
        }
    }

    // MARK: Controller + view clean up

    deinit {
        host?.willMove(toParent: nil)
        host?.view.removeFromSuperview()
        host?.removeFromParent()
        host = nil
    }
}

protocol CardContent {
    var imageName: String { get }
    var title: String { get }
    var description: String { get }
}

struct Card: View {
    typealias Content = CardContent

    let content: Content

    var body: some View {
        VStack(alignment: .leading, spacing: 8) {
            // Image(systemName: "photo.artframe")
            // .resizable()
            Image(content.imageName)
                .fitToAspectRatio(3 / 2)
                .clipShape(RoundedRectangle(cornerRadius: 4))

            // Text("Condo with awesome views of downtown")
            Text(content.title)
                .font(.headline)

            // Text("$42 avg/night")
            Text(content.description)
                .font(.body)
                .lineLimit(1)
        }
    }
}

// https://gist.github.com/karigrooms/fdf435274f4403abd57b1ed533dcea53

import SwiftUI

/// Common aspect ratios
public enum AspectRatio: CGFloat {
    case square = 1
    case threeToFour = 0.75
    case fourToThree = 1.75
}

/// Fit an image to a certain aspect ratio while maintaining its aspect ratio
public struct FitToAspectRatio: ViewModifier {
    private let aspectRatio: CGFloat

    public init(_ aspectRatio: CGFloat) {
        self.aspectRatio = aspectRatio
    }

    public init(_ aspectRatio: AspectRatio) {
        self.aspectRatio = aspectRatio.rawValue
    }

    public func body(content: Content) -> some View {
        ZStack {
            Rectangle()
                .fill(Color(.clear))
                .aspectRatio(aspectRatio, contentMode: .fit)

            content
                .scaledToFill()
                .layoutPriority(-1)
        }
        .clipped()
    }
}

// Image extension that composes with the `.resizable()` modifier
public extension Image {
    func fitToAspectRatio(_ aspectRatio: CGFloat) -> some View {
        resizable().modifier(FitToAspectRatio(aspectRatio))
    }

    func fitToAspectRatio(_ aspectRatio: AspectRatio) -> some View {
        resizable().modifier(FitToAspectRatio(aspectRatio))
    }
}

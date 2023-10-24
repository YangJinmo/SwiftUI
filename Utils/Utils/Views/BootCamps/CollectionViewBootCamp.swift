//
//  CollectionViewBootCamp.swift
//  Utils
//
//  Created by Jmy on 2023/09/23.
//

import SwiftUI
import UIKit

struct CardItem: MyCollectionViewCell.Content {
    var id: String
    var imageName: String
    var title: String
    var description: String
    var imageURL: String
}

final class CollectionViewBootCamp: UIViewController {
    let cardItems: [CardItem] = [
        CardItem(id: UUID().uuidString, imageName: "condos", title: "Condo with awesome views of downtown", description: "$117 avg/night", imageURL: "https://www.forbes.com/advisor/wp-content/uploads/2022/10/condo-vs-apartment.jpeg.jpg"),
        CardItem(id: UUID().uuidString, imageName: "houses", title: "Oceanfront 3 BR/3 BA", description: "$400 avg/night", imageURL: "https://thumbor.forbes.com/thumbor/fit-in/900x510/https://www.forbes.com/home-improvement/wp-content/uploads/2022/07/download-23.jpg"),
        CardItem(id: UUID().uuidString, imageName: "studios", title: "Art Studio", description: "$65 avg/night", imageURL: "https://www.sweetwater.com/insync/media/2019/09/5cce6b1f-091919-insync-tourgearsweetwaterstudio.jpg"),
        CardItem(id: UUID().uuidString, imageName: "villas", title: "Luxury 4 BR/3 BA Villa", description: "$109 avg/night", imageURL: "https://cf.bstatic.com/xdata/images/hotel/max1024x768/415304940.jpg?k=7446785620db62901eca0c847ba71dab1097fb9d5c4b614234b7909fd78d7f71&o=&hp=1"),
        CardItem(id: UUID().uuidString, imageName: "cabins", title: "Cabin in the Pike", description: "$200 avg/night", imageURL: "https://static.wixstatic.com/media/3ffa1d_54089e5082b448c49c4e803543841971~mv2.jpg/v1/fit/w_479,h_320,q_90/3ffa1d_54089e5082b448c49c4e803543841971~mv2.jpg"),
        CardItem(id: UUID().uuidString, imageName: "bungalows", title: "Cottage on Ocean Bluff", description: "$159 avg/night", imageURL: "https://www.journeyera.com/wp-content/uploads/2023/05/Overwater_bungalows_caribbean-46-1024x683.jpg"),
        CardItem(id: UUID().uuidString, imageName: "resorts", title: "Terranea Oceanside King Casita", description: "$351 avg/night", imageURL: "https://images.lifestyleasia.com/wp-content/uploads/sites/6/2022/03/04111335/amandari-indonesia-suite-exterior-and-pool_original_11588-2-1401x900.jpg"),
        CardItem(id: UUID().uuidString, imageName: "chalets", title: "Romantic Mountain Chalet", description: "$104 avg/night", imageURL: "https://3792.ch/wp-content/uploads/2022/03/canstockphoto96476824-scaled.jpg"),
        CardItem(id: UUID().uuidString, imageName: "farmhouses", title: "Cozy Farmhouse on 10 Acres", description: "$199 avg/night", imageURL: "https://agavecustomhomes.com/wp-content/uploads/2022/02/Agave-Custom-Homes-American-Farmhouse.jpg"),
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

        logo.setImage(urlString: "https://i.pinimg.com/originals/df/5f/d4/df5fd4cc30ed0eddb4c2bb45645586a5.png")
    }

    private func setupView() {
        view.addSubview(logo)
        view.addSubview(label)
        view.addSubview(collectionView)

        NSLayoutConstraint.activate([
            logo.topAnchor.constraint(equalTo: view.topAnchor),
            logo.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            logo.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            logo.heightAnchor.constraint(equalToConstant: 80),

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
        return cardItems.count
    }

    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: MyCollectionViewCell.reuseIdentifier, for: indexPath) as? MyCollectionViewCell else {
            fatalError("Could not dequeue cell")
        }

        let item = cardItems[indexPath.row]
        cell.configure(with: item, parent: self)
        cell.handler = handler(item:)

        return cell
    }

    func handler(item: Card.Content?) {
        guard let item = item else {
            print("No item")
            return
        }

        print("handler: \(item.id)")
    }
}

extension CollectionViewBootCamp: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: 240, height: 320)
    }
}

extension CollectionViewBootCamp: UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let item = cardItems[indexPath.item]
        print("didSelectItemAt: \(item.id)")
//        let pdp = PropertyDetailsViewController(property: item)
//        pdp.modalPresentationStyle = .formSheet
//        present(pdp, animated: true)
    }
}

struct CollectionViewBootCampPreviews: View {
    var body: some View {
        ViewControllerRepresentable {
            CollectionViewBootCamp()
        }
        .environmentObject(HeartsProvider())
    }
}

struct CollectionViewBootCamp_Previews: PreviewProvider {
    static var previews: some View {
        CollectionViewBootCampPreviews()
    }
}

import SwiftUI
import UIKit

class MyCollectionViewCell: SwiftUICollectionViewCell<Card> {
    static var reuseIdentifier = "MyCollectionViewCell"

    typealias Content = Card.Content

    lazy var heartButton: UIHeartButton = {
        UIHeartButton()
    }()

    var content: Card.Content?
    var handler: ((Card.Content?) -> Void)?

    override init(frame: CGRect) {
        super.init(frame: frame)

        contentView.addSubview(heartButton)
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    func configure(with content: Content, parent: UIViewController) {
        embed(in: parent, withView: Card(content: content))
        host?.view.frame = contentView.bounds

        self.content = content

        // UIButton layout
        heartButton.frame = CGRect(x: contentView.bounds.width - 60, y: 20, width: 40, height: 40)
        contentView.bringSubviewToFront(heartButton)

        // heartButton.addAction(UIAction(handler: { [weak self] _ in self?.buttonTapped() }), for: .touchUpInside)
        heartButton.addAction(UIAction { [weak self] _ in self?.buttonTapped() }, for: .touchUpInside)
    }

    @objc private func buttonTapped() {
        handler?(content)
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
    var id: String { get }
    var imageName: String { get }
    var title: String { get }
    var description: String { get }
    var imageURL: String { get }
}

struct Card: View {
    typealias Content = CardContent

    let content: Content

    @EnvironmentObject var heartsProvider: HeartsProvider

    var body: some View {
        ZStack(alignment: .topTrailing) {
            VStack(alignment: .leading, spacing: 8) {
                // Image(systemName: "photo.artframe")
                // .resizable()

                // Image(content.imageName)
                // .fitToAspectRatio(3 / 2)
                // .clipShape(RoundedRectangle(cornerRadius: 4))

                // AsyncImageView(url: content.imageURL)
                // .fitToAspectRatio(3 / 2)
                // .clipShape(RoundedRectangle(cornerRadius: 4))

                CacheAsyncImageView(url: content.imageURL)
                    .fitToAspectRatio(3 / 2)
                    .clipShape(RoundedRectangle(cornerRadius: 4))

                // Text("Condo with awesome views of downtown")
                Text(content.title)
                    .font(.headline)

                // Text("$42 avg/night")
                Text(content.description)
                    .font(.body)
                    .lineLimit(1)

                Spacer()
            }

//            HeartButton(isHearted: heartsProvider.isHearted(id: content.id), action: {
//                self.heartsProvider.toggle(id: content.id)
//            })
//            .padding()
        }
    }
}

// MARK: HeartButton

struct HeartButton: View {
    let isHearted: Bool
    let action: () -> Void

    var body: some View {
        Button(action: action, label: {
            Image(systemName: "heart")
                .imageScale(.medium)
                .symbolVariant(isHearted ? .fill : .none)
                .foregroundColor(isHearted ? .red : .primary)
        })
        .buttonStyle(CircleButtonStyle(backgroundColor: .white))
    }
}

// MARK: HeartsProvider

import SwiftUI

final class HeartsProvider: ObservableObject {
    @Published var hearts: [String] = []

    func isHearted(id: String) -> Bool {
        return hearts.contains(id)
    }

    func toggle(id: String) {
        if let index = hearts.firstIndex(of: id) {
            hearts.remove(at: index)
        } else {
            hearts.append(id)
        }
    }
}

extension UIImageView {
    // MARK: - Error

    private func toURL(urlString: String?) -> URL? {
        guard let urlString = urlString else {
            "Error: urlString is nil".log()
            return nil
        }
        guard let url = urlString.toURL else {
            return nil
        }
        return url
    }

    // MARK: - Asynchronously

    func setImage(urlString: String?) {
        guard let url = toURL(urlString: urlString) else {
            return
        }

        DispatchQueue.global().async { [weak self] in
            do {
                let data = try Data(contentsOf: url)
                let image = UIImage(data: data)

                DispatchQueue.main.async {
                    self?.image = image
                }
            } catch {
                "Error: \(error)".log()
            }
        }
    }
}

final class UIHeartButton: BaseButton {
    private lazy var config: UIButton.Configuration = {
        var configuration = UIButton.Configuration.filled()
        configuration.image = UIImage(systemName: "heart")
        configuration.baseBackgroundColor = .white
        configuration.baseForegroundColor = .red
        configuration.cornerStyle = .capsule
        configuration.buttonSize = .small
        return configuration
    }()

    override func commonInit() {
        configuration = config
    }
}

import UIKit

class BaseButton: UIButton {
    // MARK: - Initialization

    override init(frame: CGRect) {
        super.init(frame: frame)

        commonInit()
    }

    required init?(coder: NSCoder) {
        super.init(coder: coder)

        commonInit()
    }

    // MARK: - Methods

    func commonInit() {
    }
}

extension UIButton {
    convenience init(handler: @escaping () -> Void) {
        self.init(
            primaryAction: UIAction(
                handler: { _ in handler() }
            )
        )
    }
}

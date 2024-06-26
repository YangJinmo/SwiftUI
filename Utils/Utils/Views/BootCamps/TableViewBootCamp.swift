//
//  TableViewBootCamp.swift
//  Utils
//
//  Created by Jmy on 2023/09/19.
//

import SwiftUI
import UIKit

final class TableViewBootCamp: UITableViewController {
    private let reuseIdentifier = "TableViewBootCamp"

    override func viewDidLoad() {
        super.viewDidLoad()

        tableView.register(UITableViewCell.self, forCellReuseIdentifier: reuseIdentifier)
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 10
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: reuseIdentifier) else {
            fatalError("You forgot to register your table view cell")
        }

        // Example content based on:
        // https://developer.apple.com/documentation/uikit/uilistcontentconfiguration
//        var listContentConfiguration = cell.defaultContentConfiguration()
//        listContentConfiguration.image = UIImage(systemName: "star")
//        listContentConfiguration.text = "Favorites"
//        listContentConfiguration.imageProperties.tintColor = .purple
//
//        cell.contentConfiguration = listContentConfiguration

        let swiftUIContent = {
            HStack {
                Image(systemName: "star")
                    .foregroundColor(.purple)

                Text("Favorites")

                Spacer() // A spacer to left align the 2 views above
            }
        }

        if #available(iOS 16.0, *) {
            cell.contentConfiguration = UIHostingConfiguration(content: swiftUIContent)
        } else {
            cell.contentConfiguration = HostingContentConfiguration {
                // We add a little bit of padding & height to match the UIHostingConfiguration
                swiftUIContent()
                    .padding()
                    .frame(height: 44)
            }
        }

        return cell
    }
}

// MARK: - Preview

import SwiftUI

#Preview {
    ViewControllerRepresentable {
        TableViewBootCamp()
    }
    .ignoresSafeArea()
}

//
//  TableViewBootCamp.swift
//  Utils
//
//  Created by Jmy on 2023/09/19.
//

import SwiftUI
import UIKit

class TableViewBootCamp: UITableViewController {
    private let aCellIdentifier = "someIdentifier"

    override func viewDidLoad() {
        super.viewDidLoad()

        tableView.register(UITableViewCell.self, forCellReuseIdentifier: aCellIdentifier)
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 10
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: aCellIdentifier) else {
            fatalError("You forgot to register your table view cell")
        }

        // Example content based on:
        // https://developer.apple.com/documentation/uikit/uilistcontentconfiguration
        var listContentConfiguration = cell.defaultContentConfiguration()
        listContentConfiguration.image = UIImage(systemName: "star")
        listContentConfiguration.text = "Favorites"
        listContentConfiguration.imageProperties.tintColor = .purple

        cell.contentConfiguration = listContentConfiguration

        return cell
    }
}

// MARK: - Preview

import SwiftUI

struct TableViewBootCamp_Previews: PreviewProvider {
    static var previews: some View {
        ViewControllerRepresentable {
            TableViewBootCamp()
        }
        .ignoresSafeArea()
    }
}

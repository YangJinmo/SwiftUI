//
//  UnitTestingBootcampViewModel.swift
//  Utils
//
//  Created by Jmy on 4/9/24.
//

import SwiftUI

class UnitTestingBootcampViewModel: ObservableObject {
    @Published var isPremium: Bool
    @Published var dataArray: [String] = []
    @Published var selectedItem: String? = nil

    init(isPremium: Bool) {
        self.isPremium = isPremium
    }

    func addItem(item: String) {
        guard !item.isEmpty else { return }
        dataArray.append(item)
    }

    func selectItem(item: String) {
        if let x = dataArray.first(where: { $0 == item }) {
            selectedItem = x
        } else {
            selectedItem = nil
        }
    }
}

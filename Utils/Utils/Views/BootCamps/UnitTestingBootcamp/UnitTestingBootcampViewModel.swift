//
//  UnitTestingBootcampViewModel.swift
//  Utils
//
//  Created by Jmy on 4/9/24.
//

import Combine
import SwiftUI

protocol NewDataServiceProtocol {
    func downloadItemWithEscaping(completion: @escaping (_ items: [String]) -> Void)
    func downloadItemsCombine() -> AnyPublisher<[String], Error>
}

class NewMockDataService: NewDataServiceProtocol {
    let items: [String]

    init(items: [String]?) {
        self.items = items ?? [
            "ONE", "TWO", "THREE",
        ]
    }

    func downloadItemWithEscaping(completion: @escaping (_ items: [String]) -> Void) {
        DispatchQueue.main.asyncAfter(deadline: .now() + 3) {
            completion(self.items)
        }
    }

    func downloadItemsCombine() -> AnyPublisher<[String], Error> {
        Just(items)
            .tryMap({ publishedItems in
                guard !publishedItems.isEmpty else {
                    throw URLError(.badServerResponse)
                }
                return publishedItems
            })
            .eraseToAnyPublisher()
    }
}

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

    func saveItem(item: String) throws {
        guard !item.isEmpty else {
            throw DataError.noData
        }

        if let x = dataArray.first(where: { $0 == item }) {
            print("Save item here!!! \(x)")
        } else {
            throw DataError.itemNotFound
        }
    }

    enum DataError: LocalizedError {
        case noData
        case itemNotFound
    }
}

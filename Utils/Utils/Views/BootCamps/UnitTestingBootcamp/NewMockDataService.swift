//
//  NewMockDataService.swift
//  Utils
//
//  Created by Jmy on 5/2/24.
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

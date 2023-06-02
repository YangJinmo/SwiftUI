//
//  PhotoPickerService.swift
//  PHPicker
//
//  Created by Jmy on 2023/06/02.
//

import Combine
import Photos
import PhotosUI
import SwiftUI

final class PhotoPickerService: ObservableObject {
    @Published var isPresented = false
    @Published var filters: [PHPickerFilter] = []
    @Published var selectionLimit = 1
    @Published var results = [PHPickerResult]()

    private var cancellables: Set<AnyCancellable> = []

    init() {
        $isPresented
            .sink { isPresented in
                if !isPresented {
                    self.reset()
                }
            }
            .store(in: &cancellables)
    }

    func present(filters: [PHPickerFilter] = [.images], selectionLimit: Int = 1) {
        self.filters = filters
        self.selectionLimit = selectionLimit
        isPresented = true
    }

    private func reset() {
        filters.removeAll()
        selectionLimit = 1
    }
}

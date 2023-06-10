//
//  KeyboardObserver.swift
//  Utils
//
//  Created by Jmy on 2023/06/05.
//

import Combine
import SwiftUI

final class KeyboardObserver: ObservableObject {
    @Published var keyboardIsVisible: Bool = false
    private var cancellables = Set<AnyCancellable>()

    init() {
        NotificationCenter.default.publisher(for: UIResponder.keyboardWillShowNotification)
            .sink { _ in
                self.keyboardIsVisible = true
            }
            .store(in: &cancellables)

        NotificationCenter.default.publisher(for: UIResponder.keyboardWillHideNotification)
            .sink { _ in
                self.keyboardIsVisible = false
            }
            .store(in: &cancellables)
    }
}

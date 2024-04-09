//
//  UnitTestingBootcampViewModel.swift
//  Utils
//
//  Created by Jmy on 4/9/24.
//

import SwiftUI

class UnitTestingBootcampViewModel: ObservableObject {
    @Published var isPremium: Bool

    init(isPremium: Bool) {
        self.isPremium = isPremium
    }
}

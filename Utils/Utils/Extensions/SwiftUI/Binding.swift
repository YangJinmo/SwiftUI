//
//  Binding.swift
//  Utils
//
//  Created by Jmy on 1/18/24.
//

import SwiftUI

extension Binding where Value == Bool {
    init<T>(value: Binding<T?>) {
        self.init {
            value.wrappedValue != nil
        } set: { newValue in
            if !newValue {
                value.wrappedValue = nil
            }
        }
    }
}

extension Binding where Value == String {
    func max(_ limit: Int) -> Self {
        if wrappedValue.count > limit {
            DispatchQueue.main.async {
                wrappedValue = String(wrappedValue.dropLast())
            }
        }
        return self
    }
}

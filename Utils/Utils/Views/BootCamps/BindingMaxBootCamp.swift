//
//  BindingMaxBootCamp.swift
//  Utils
//
//  Created by Jmy on 1/18/24.
//

import SwiftUI

struct BindingMaxBootCamp: View {
    @State private var text: String = ""
    let max = 6

    var body: some View {
        TextField("Text max \(max)", text: $text.max(max))
            .padding()
            .textFieldStyle(RoundedBorderTextFieldStyle())
    }
}

#Preview {
    BindingMaxBootCamp()
}

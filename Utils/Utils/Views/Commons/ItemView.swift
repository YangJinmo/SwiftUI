//
//  ItemView.swift
//  Utils
//
//  Created by Jmy on 2023/07/09.
//

import SwiftUI

struct ItemView: View {
    let text: String
    let textTapped: (String) -> Void

    var body: some View {
        Button {
            textTapped(text)
        } label: {
            Text(text)
                .foregroundColor(.gray100)
                .font(.subheadline)
        }
        .padding(.horizontal, 16)
        .padding(.vertical, 8)
        .background(Color.gray700)
        .clipShape(Capsule())
    }
}

#Preview {
    ItemView(text: "Apple") { text in
        print("Selected text: \(text)")
    }
}

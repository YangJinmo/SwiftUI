//
//  DeletableItemView.swift
//  Utils
//
//  Created by Jmy on 2023/06/25.
//

import SwiftUI

struct DeletableItemView: View {
    let text: String
    let textTapped: (String) -> Void
    let xmarkTapped: (String) -> Void

    var body: some View {
        HStack(spacing: 8) {
            Button {
                textTapped(text)
            } label: {
                Text(text)
                    .font(.subheadline)
                    .foregroundColor(.gray100)
            }

            Button {
                xmarkTapped(text)
            } label: {
                Image.xmark
                    .renderingMode(.template)
                    .foregroundColor(.gray500)
                    .frame(width: 12, height: 12)
            }
        }
        .padding(.horizontal, 16)
        .padding(.vertical, 8)
        .background(Color.gray700)
        .clipShape(Capsule())
    }
}

#Preview {
    DeletableItemView(text: "검색어") { text in
        print("Selected text: \(text)")
    } xmarkTapped: { _ in
        print("xmark Tapped")
    }
}

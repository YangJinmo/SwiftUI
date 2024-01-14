//
//  HorizontalScrollableItemView.swift
//  Utils
//
//  Created by Jmy on 2023/07/12.
//

import SwiftUI

struct HorizontalScrollableItemView: View {
    let texts: [String]
    let textTapped: (String) -> Void

    var body: some View {
        ScrollView(.horizontal, showsIndicators: false) {
            HStack(spacing: 8) {
                ForEach(texts, id: \.self) { text in
                    ItemView(text: text) { text in
                        textTapped(text)
                    }
                }
            }
            .padding(.horizontal, 16)
        }
    }
}

#Preview {
    HorizontalScrollableItemView(
        texts: ["Apple", "Samsung"],
        textTapped: { text in
            print(text)
        }
    )
}

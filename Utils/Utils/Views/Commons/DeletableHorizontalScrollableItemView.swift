//
//  DeletableHorizontalScrollableItemView.swift
//  Utils
//
//  Created by Jmy on 2023/07/13.
//

import SwiftUI

struct DeletableHorizontalScrollableItemView: View {
    let texts: [String]
    let textTapped: (String) -> Void
    let xmarkTapped: (Int) -> Void

    var body: some View {
        ScrollView(.horizontal, showsIndicators: false) {
            HStack(spacing: 8) {
                ForEach(texts, id: \.self) { text in
                    DeletableItemView(text: text) { text in
                        textTapped(text)
                    } xmarkTapped: { text in
                        if let index = texts.firstIndex(of: text) {
                            xmarkTapped(index)
                        }
                    }
                }
            }
            .padding(.horizontal, 16)
        }
    }
}

struct DeletableHorizontalScrollableItemView_Previews: PreviewProvider {
    static var previews: some View {
        DeletableHorizontalScrollableItemView(
            texts: ["Apple", "Samsung"],
            textTapped: { text in
                print(text)
            },
            xmarkTapped: { index in
                print(index)
            }
        )
    }
}

//
//  DeletableItemView.swift
//  Utils
//
//  Created by Jmy on 2023/06/25.
//

import SwiftUI

struct DeletableItemView: View {
    @Binding var text: String
    let textTapped: (String) -> Void
    let xmarkTapped: (String) -> Void

    var body: some View {
        HStack(spacing: 4) {
            Button(action: {
                textTapped(text)
            }, label: {
                Text(text)
                    .foregroundColor(.gray100)
                    .font(.subheadline)
            })

            Button(action: {
                xmarkTapped(text)
            }, label: {
                Image(systemName: "xmark")
                    .frame(width: 18, height: 18)
            })
        }
        .padding(.horizontal, 16)
        .padding(.vertical, 8)
        .background(Color.gray700)
        .cornerRadius(17)
    }
}

struct DeletableItemView_Previews: PreviewProvider {
    static var previews: some View {
        DeletableItemView(text: Binding<String>.init(
            get: { "Apple" },
            set: { _ in }
        )) { text in
            print("Selected text: \(text)")
        } xmarkTapped: { _ in
            print("Xmark Tapped")
        }
    }
}

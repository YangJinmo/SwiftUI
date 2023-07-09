//
//  ItemView.swift
//  Utils
//
//  Created by Jmy on 2023/07/09.
//

import SwiftUI

struct ItemView: View {
    @Binding var text: String
    let textTapped: (String) -> Void

    var body: some View {
        HStack(spacing: 4) {
            Button(action: {
                textTapped(text)
            }, label: {
                Text(text)
                    .foregroundColor(.gray100)
                    .font(.subheadline)
            })
        }
        .padding(.horizontal, 16)
        .padding(.vertical, 8)
        .background(Color.gray700)
        .cornerRadius(17)
    }
}

struct ItemView_Previews: PreviewProvider {
    static var previews: some View {
        ItemView(text: Binding<String>.init(
            get: { "Apple" },
            set: { _ in }
        )) { text in
            print("Selected text: \(text)")
        }
    }
}

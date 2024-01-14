//
//  AsyncImageView.swift
//  Utils
//
//  Created by Jmy on 2023/06/20.
//

import SwiftUI

struct AsyncImageView: View {
    var url: String?

    var body: some View {
        AsyncImage(url: url?.toURL) { phase in
            switch phase {
            case .empty:
                ProgressView()

            case let .success(image):
                image.resizable()
                    .scaledToFit()

            case .failure:
                Image.photo
                    .foregroundColor(.white)

            @unknown default:
                EmptyView()
            }
        }
    }
}

#Preview {
    AsyncImageView(url: "https://developer.apple.com/assets/elements/icons/swiftui/swiftui-96x96_2x.png")
}

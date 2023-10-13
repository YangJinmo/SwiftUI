//
//  CacheAsyncImageView.swift
//  Utils
//
//  Created by Jmy on 2023/10/12.
//

import SwiftUI

struct CacheAsyncImageView: View {
    var url: String?

    var body: some View {
        if let url = url?.toURL {
            CacheAsyncImage(url: url) { phase in
                switch phase {
                case .empty:
                    ProgressView()

                case let .success(image):
                    image.resizable()
                        .scaledToFit()

                case .failure:
                    Image.photo
                        .foregroundColor(.primary)

                @unknown default:
                    EmptyView()
                }
            }
        }
    }
}

struct CacheAsyncImageView_Previews: PreviewProvider {
    static var previews: some View {
        CacheAsyncImageView(url: "https://www.forbes.com/advisor/wp-content/uploads/2022/10/condo-vs-apartment.jpeg.jpg")
            .fitToAspectRatio(3 / 2)
            .clipShape(RoundedRectangle(cornerRadius: 4))
            .padding()
    }
}

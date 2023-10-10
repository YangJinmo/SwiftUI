//
//  CacheAsyncImage.swift
//  Utils
//
//  Created by Jmy on 2023/10/08.
//

import SwiftUI

struct CacheAsyncImage<Content>: View where Content: View {
    private let url: URL
    private let scale: CGFloat
    private let transaction: Transaction
    private let content: (AsyncImagePhase) -> Content

    init(
        url: URL,
        scale: CGFloat = 1.0,
        transaction: Transaction = Transaction(),
        @ViewBuilder content: @escaping (AsyncImagePhase) -> Content
    ) {
        self.url = url
        self.scale = scale
        self.transaction = transaction
        self.content = content
    }

    var body: some View {
        if let cached = ImageCache[url] {
            // let _ = print("cached: \(url.absoluteString)")
            content(.success(cached))
        } else {
            let _ = print("request: \(url.absoluteString)")
            AsyncImage(
                url: url,
                scale: scale,
                transaction: transaction
            ) { phase in
                cacheAndRender(phase: phase)
            }
        }
    }

    func cacheAndRender(phase: AsyncImagePhase) -> some View {
        if case let .success(image) = phase {
            ImageCache[url] = image
        }
        return content(phase)
    }
}

fileprivate class ImageCache {
    private static var cache: [URL: Image] = [:]
    static subscript(url: URL) -> Image? {
        get {
            ImageCache.cache[url]
        }
        set {
            ImageCache.cache[url] = newValue
        }
    }
}

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
                        .foregroundColor(.white)

                @unknown default:
                    EmptyView()
                }
            }
        }
    }
}

#Preview {
    CacheAsyncImageView(url: "https://www.forbes.com/advisor/wp-content/uploads/2022/10/condo-vs-apartment.jpeg.jpg")
        .fitToAspectRatio(3 / 2)
        .clipShape(RoundedRectangle(cornerRadius: 4))
        .padding()
}

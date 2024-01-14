//
//  ImageView.swift
//  Utils
//
//  Created by Jmy on 2023/10/16.
//

import SwiftUI

struct ImageView<Placeholder>: View where Placeholder: View {
    // MARK: - Properties

    // MARK: Private

    @State private var image: Image? = nil
    @State private var task: Task<Void, Never>? = nil
    @State private var isProgressing = false

    private let url: URL?
    private let placeholder: () -> Placeholder?

    // MARK: - Initializer

    init(url: URL?, @ViewBuilder placeholder: @escaping () -> Placeholder) {
        self.url = url
        self.placeholder = placeholder
    }

    init(url: URL?) where Placeholder == Color {
        self.init(url: url, placeholder: { Color("neutral9") })
    }

    // MARK: - View

    // MARK: Public

    var body: some View {
        GeometryReader { proxy in
            ZStack {
                placholderView
                imageView
                progressView
            }
            .frame(width: proxy.size.width, height: proxy.size.height)
            .task {
                task?.cancel()
                task = Task.detached(priority: .background) {
                    await MainActor.run { isProgressing = true }

                    do {
                        let image = try await ImageManager.shared.download(url: url)

                        await MainActor.run {
                            isProgressing = false
                            self.image = image
                        }

                    } catch {
                        await MainActor.run { isProgressing = false }
                    }
                }
            }
            .onDisappear {
                task?.cancel()
            }
        }
    }

    // MARK: Private

    @ViewBuilder
    private var imageView: some View {
        if let image = image {
            image
                .resizable()
                .scaledToFill()
        }
    }

    @ViewBuilder
    private var placholderView: some View {
        if !isProgressing, image == nil {
            placeholder()
        }
    }

    @ViewBuilder
    private var progressView: some View {
        if isProgressing {
            ProgressView()
                .progressViewStyle(.circular)
        }
    }
}

#if DEBUG
    #Preview {
        let urls = [
            "https://wallpaperset.com/w/full/8/c/9/29296.jpg",
            "https://wallpaperset.com/w/full/8/2/8/29299.jpg",
            "https://wallpaperset.com/w/full/c/e/1/29301.jpg",
            "https://wallpaperset.com/w/full/2/6/e/29303.jpg",
            "https://wallpaperset.com/w/full/e/5/f/29306.jpg",
            "https://wallpaperset.com/w/full/6/f/b/29309.jpg",
            "https://wallpaperset.com/w/full/4/c/d/29311.jpg",
            "https://wallpaperset.com/w/full/2/a/4/29313.jpg",
            "https://wallpaperset.com/w/full/d/d/d/29472.jpg",
        ]

        let view = List(urls, id: \.self) { url in
            ImageView(url: URL(string: url)) {
                Text("⚠️")
                    .font(.system(size: 120))
            }
            .frame(width: 300, height: 300)
            .cornerRadius(20)
        }

        return view
            .previewDevice("iPhone 11 Pro")
            .preferredColorScheme(.light)
    }
#endif

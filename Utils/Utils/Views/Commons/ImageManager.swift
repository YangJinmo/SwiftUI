//
//  ImageManager.swift
//  Utils
//
//  Created by Jmy on 2023/10/16.
//
import Combine
import Photos
import SwiftUI

final class ImageManager {
    // MARK: - Singleton

    static let shared = ImageManager()

    // MARK: - Properties

    // MARK: Private

    private lazy var imageCache = NSCache<NSString, UIImage>()
    private var loadTasks = [PHAsset: PHImageRequestID]()

    private let queue = DispatchQueue(label: "ImageDataManagerQueue")

    private lazy var imageManager: PHCachingImageManager = {
        let imageManager = PHCachingImageManager()
        imageManager.allowsCachingHighQualityImages = true
        return imageManager
    }()

    private lazy var downloadSession: URLSession = {
        let configuration = URLSessionConfiguration.default
        configuration.httpMaximumConnectionsPerHost = 90
        configuration.timeoutIntervalForRequest = 90
        configuration.timeoutIntervalForResource = 90
        return URLSession(configuration: configuration)
    }()

    // MARK: - Initializer

    private init() {}

    // MARK: - Function

    // MARK: Public

    func download(url: URL?) async throws -> Image {
        guard let url = url else { throw URLError(.badURL) }

        if let cachedImage = imageCache.object(forKey: url.absoluteString as NSString) {
            return Image(uiImage: cachedImage)
        }

        let data = (try await downloadSession.data(from: url)).0

        guard let image = UIImage(data: data) else { throw URLError(.badServerResponse) }
        queue.async { self.imageCache.setObject(image, forKey: url.absoluteString as NSString) }

        return Image(uiImage: image)
    }
}

//
//  PhotoPickerResultView.swift
//  PHPicker
//
//  Created by Jmy on 2023/06/02.
//

import AVKit
import PhotosUI
import SwiftUI

struct PhotoPickerResultView: View {
    var result: PHPickerResult

    enum MediaType {
        case loading, error, photo, video, livePhoto
    }

    @State private var mediaType: MediaType = .loading

    @State private var photo: UIImage?
    @State private var url: URL?
    @State private var livePhoto: PHLivePhoto?

    @State private var loaded = false
    @State private var latestErrorDescription = ""

    var body: some View {
        Group {
            switch mediaType {
            case .loading:
                ProgressView()

            case .error:
                VStack {
                    Image(systemName: "exclamationmark.triangle.fill")
                    Text(latestErrorDescription).font(.caption)
                }
                .foregroundColor(.gray)

            case .photo:
                if photo != nil {
                    Image(uiImage: photo!)
                        .resizable()
                } else {
                    EmptyView()
                }

            case .video:
                if url != nil {
                    VideoPlayer(player: AVPlayer(url: url!))
                } else {
                    EmptyView()
                }

            case .livePhoto:
                if livePhoto != nil {
                    LivePhotoView(livePhoto: livePhoto!)
                } else {
                    EmptyView()
                }
            }
        }
        .onAppear {
            if !loaded {
                loadObject()
            }
        }
    }

    func loadObject() {
        let itemProvider = result.itemProvider

        guard let typeIdentifier = itemProvider.registeredTypeIdentifiers.first, let utType = UTType(typeIdentifier) else {
            latestErrorDescription = "Could not find type identifier"
            mediaType = .error
            loaded = true
            return
        }

        if utType.conforms(to: .image) {
            getPhoto(from: itemProvider, objectType: UIImage.self)
        } else if utType.conforms(to: .movie) {
            getVideo(from: itemProvider, typeIdentifier: typeIdentifier)
        } else if utType.conforms(to: .livePhoto) {
            getPhoto(from: itemProvider, objectType: PHLivePhoto.self)
        }
    }

    private func getPhoto(from itemProvider: NSItemProvider, objectType: NSItemProviderReading.Type) {
        guard itemProvider.canLoadObject(ofClass: objectType) else {
            latestErrorDescription = "itemProvider can not load object of class: \(objectType)"
            mediaType = .error
            loaded = true
            return
        }

        itemProvider.loadObject(ofClass: objectType) { object, error in
            if let error = error {
                print(error.localizedDescription)
                latestErrorDescription = error.localizedDescription
                mediaType = .error
                loaded = true
            }

            if objectType == UIImage.self {
                if let image = object as? UIImage {
                    DispatchQueue.main.async {
                        self.mediaType = .photo
                        self.photo = image
                        self.loaded = true
                    }
                }
            } else {
                if let livePhoto = object as? PHLivePhoto {
                    DispatchQueue.main.async {
                        self.mediaType = .livePhoto
                        self.livePhoto = livePhoto
                        self.loaded = true
                    }
                }
            }
        }
    }

    private func getVideo(from itemProvider: NSItemProvider, typeIdentifier: String) {
        guard itemProvider.hasItemConformingToTypeIdentifier(typeIdentifier) else {
            latestErrorDescription = "itemProvider has not item conforming to typeIdentifier"
            mediaType = .error
            loaded = true
            return
        }

        itemProvider.loadFileRepresentation(forTypeIdentifier: typeIdentifier) { url, error in
            if let error = error {
                print(error.localizedDescription)
                latestErrorDescription = error.localizedDescription
                mediaType = .error
                loaded = true
            }

            guard let url = url else {
                latestErrorDescription = "Url is nil"
                mediaType = .error
                loaded = true
                return
            }

            let documentsDirectory = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first

            guard let targetURL = documentsDirectory?.appendingPathComponent(url.lastPathComponent) else {
                latestErrorDescription = "Failed to create target url"
                mediaType = .error
                loaded = true
                return
            }

            do {
                if FileManager.default.fileExists(atPath: targetURL.path) {
                    try FileManager.default.removeItem(at: targetURL)
                }

                try FileManager.default.copyItem(at: url, to: targetURL)

                DispatchQueue.main.async {
                    self.mediaType = .video
                    self.url = targetURL
                    self.loaded = true
                }
            } catch {
                print(error.localizedDescription)
                latestErrorDescription = error.localizedDescription
                mediaType = .error
                loaded = true
            }
        }
    }

    func removeAll() {
        switch mediaType {
        case .photo: photo = nil
        case .livePhoto: livePhoto = nil
        case .video:
            guard let url = url else { return }
            try? FileManager.default.removeItem(at: url)
            self.url = nil
        default:
            print("Default")
        }
    }
}

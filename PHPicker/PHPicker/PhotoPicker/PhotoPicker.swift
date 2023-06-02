//
//  PhotoPicker.swift
//  PHPicker
//
//  Created by Jmy on 2023/06/02.
//

import PhotosUI
import SwiftUI

struct PhotoPicker: UIViewControllerRepresentable {
    typealias UIViewControllerType = PHPickerViewController

    @ObservedObject var service: PhotoPickerService

    func makeUIViewController(context: Context) -> PHPickerViewController {
        var configuration = PHPickerConfiguration()
        configuration.filter = .any(of: service.filters)
        configuration.selectionLimit = service.selectionLimit
        configuration.preferredAssetRepresentationMode = .current

        let controller = PHPickerViewController(configuration: configuration)
        controller.delegate = context.coordinator
        return controller
    }

    func updateUIViewController(_ uiViewController: PHPickerViewController, context: Context) {
    }

    func makeCoordinator() -> Coordinator {
        Coordinator(with: self)
    }

    class Coordinator: PHPickerViewControllerDelegate {
        var photoPicker: PhotoPicker

        init(with photoPicker: PhotoPicker) {
            self.photoPicker = photoPicker
        }

        func picker(_ picker: PHPickerViewController, didFinishPicking results: [PHPickerResult]) {
            photoPicker.service.isPresented = false
            photoPicker.service.results = results
        }
    }
}

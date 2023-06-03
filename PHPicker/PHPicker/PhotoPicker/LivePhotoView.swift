//
//  LivePhotoView.swift
//  PHPicker
//
//  Created by Jmy on 2023/06/02.
//

import PhotosUI
import SwiftUI

struct LivePhotoView: UIViewRepresentable {
    typealias UIViewType = PHLivePhotoView

    var livePhoto: PHLivePhoto

    func makeUIView(context: Context) -> PHLivePhotoView {
        let livePhotoView = PHLivePhotoView()
        livePhotoView.contentMode = .scaleAspectFit
        return livePhotoView
    }

    func updateUIView(_ uiView: PHLivePhotoView, context: Context) {
        uiView.livePhoto = livePhoto
        uiView.startPlayback(with: .full)
    }
}

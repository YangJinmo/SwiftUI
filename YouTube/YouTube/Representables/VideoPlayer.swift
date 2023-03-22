//
//  VideoPlayer.swift
//  YouTube
//
//  Created by Jmy on 2023/03/22.
//

import AVKit
import SwiftUI

struct VideoPlayer: UIViewControllerRepresentable {
    @Binding var player: AVPlayer

    func makeUIViewController(context: Context) -> AVPlayerViewController {
        let controller = AVPlayerViewController()
        controller.player = player
        controller.showsPlaybackControls = false
        controller.allowsVideoFrameAnalysis = false
        controller.videoGravity = .resize
        return controller
    }

    func updateUIViewController(_ playerViewController: AVPlayerViewController, context: Context) {
    }
}

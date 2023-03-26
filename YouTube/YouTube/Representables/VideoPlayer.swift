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

        // repeating playback
        player.actionAtItemEnd = .none

        NotificationCenter.default.addObserver(context.coordinator, selector: #selector(context.coordinator.restartPlayback), name: .AVPlayerItemDidPlayToEndTime, object: player.currentItem)

        return controller
    }

    func updateUIViewController(_ playerViewController: AVPlayerViewController, context: Context) {
    }

    func makeCoordinator() -> Coordinator {
        return Coordinator(parent: self)
    }

    class Coordinator: NSObject {
        var parent: VideoPlayer

        init(parent: VideoPlayer) {
            self.parent = parent
        }

        @objc func restartPlayback() {
            parent.player.seek(to: .zero)
        }
    }
}

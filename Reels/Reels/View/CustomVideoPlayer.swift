//
//  CustomVideoPlayer.swift
//  Reels
//
//  Created by Jmy on 2023/03/08.
//

import AVKit
import SwiftUI

struct CustomVideoPlayer: UIViewControllerRepresentable {
//    var playerItem: AVPlayerItem?
    var player: AVPlayer

    func makeCoordinator() -> Coordinator {
        return Coordinator(parent: self)
    }

    func makeUIViewController(context: Context) -> AVPlayerViewController {
        player.automaticallyWaitsToMinimizeStalling = true
        player.playImmediately(atRate: 1)

        let controller = AVPlayerViewController()
        controller.player = player
        controller.showsPlaybackControls = false

        controller.videoGravity = .resizeAspectFill

        controller.allowsVideoFrameAnalysis = false

        // repeating playback
        player.actionAtItemEnd = .none

        NotificationCenter.default.addObserver(context.coordinator, selector: #selector(context.coordinator.restartPlayback), name: .AVPlayerItemDidPlayToEndTime, object: player.currentItem)

        return controller
    }

    func updateUIViewController(_ playerViewController: AVPlayerViewController, context: Context) {
    }

    class Coordinator: NSObject {
        var parent: CustomVideoPlayer

        init(parent: CustomVideoPlayer) {
            self.parent = parent
        }

        @objc func restartPlayback() {
            parent.player.seek(to: .zero)
        }
    }
}

struct CustomVideoPlayer_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}

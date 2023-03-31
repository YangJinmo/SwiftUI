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
//        controller.videoGravity = .resizeAspectFill
        controller.videoGravity = .resizeAspect
        controller.showsPlaybackControls = false

        if #available(iOS 16.0, *) {
            controller.allowsVideoFrameAnalysis = false
        } else {
            // Fallback on earlier versions
        }

        // repeating playback
        player.actionAtItemEnd = .none

        NotificationCenter.default.addObserver(context.coordinator, selector: #selector(context.coordinator.restartPlayback), name: .AVPlayerItemDidPlayToEndTime, object: player.currentItem)

        return controller
    }

    func updateUIViewController(_ playerViewController: AVPlayerViewController, context: Context) {
        print("updateReel: \(player.currentItem?.url?.description ?? "")")
    }

    static func dismantleUIViewController(_ uiViewController: AVPlayerViewController, coordinator: Coordinator) {
        print("dismantleReel: \(coordinator.parent.player.currentItem?.url?.description ?? "")")
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

// struct CustomVideoPlayer_Previews: PreviewProvider {
//    static var previews: some View {
//        ContentView()
//    }
// }

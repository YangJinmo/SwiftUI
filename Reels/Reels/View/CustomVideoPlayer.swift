//
//  CustomVideoPlayer.swift
//  Reels
//
//  Created by Jmy on 2023/03/08.
//

import AVKit
import SwiftUI

struct CustomVideoPlayer: UIViewControllerRepresentable {
    var player: AVPlayer

    private let audioSession = AVAudioSession.sharedInstance()

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

        addObservers(context: context)
        setAudioSession()

        return controller
    }

    func addObservers(context: Context) {
        // Repeat
        player.actionAtItemEnd = .none

        NotificationCenter.default.addObserver(
            context.coordinator,
            selector: #selector(context.coordinator.restartPlayback),
            name: .AVPlayerItemDidPlayToEndTime,
            object: player.currentItem
        )
    }

    func setAudioSession() {
        do {
            try audioSession.setCategory(.playback, mode: .moviePlayback)
            try audioSession.setActive(true, options: .notifyOthersOnDeactivation)
        } catch {
            print(error.localizedDescription)
        }
    }

    func updateUIViewController(_ playerViewController: AVPlayerViewController, context: Context) {
        print("updateReel: \(player.currentItem?.url?.description ?? "")")
    }

    static func dismantleUIViewController(_ uiViewController: AVPlayerViewController, coordinator: Coordinator) {
        print("dismantleReel: \(coordinator.parent.player.currentItem?.url?.description ?? "")")
    }

    func makeCoordinator() -> Coordinator {
        return Coordinator(parent: self)
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

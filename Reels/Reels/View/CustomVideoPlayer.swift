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

    func makeUIViewController(context: Context) -> AVPlayerViewController {
        let controller = AVPlayerViewController()
        controller.player = player
        controller.showsPlaybackControls = false

        controller.videoGravity = .resizeAspectFill

        return controller
    }

    func updateUIViewController(_ playerViewController: AVPlayerViewController, context: Context) {
    }
}

struct CustomVideoPlayer_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}

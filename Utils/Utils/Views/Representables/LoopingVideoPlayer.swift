//
//  LoopingVideoPlayer.swift
//  Utils
//
//  Created by Jmy on 2023/07/02.
//

import AVKit
import SwiftUI

struct LoopingVideoPlayer: UIViewRepresentable {
    func makeUIView(context: Context) -> some UIView {
        return LoopingVideoPlayerUIView(frame: .zero)
    }

    func updateUIView(_ uiView: UIViewType, context: Context) {
    }
}

fileprivate class LoopingVideoPlayerUIView: UIView {
    fileprivate var playerLayer = AVPlayerLayer()
    fileprivate var playerLooper: AVPlayerLooper?

    override init(frame: CGRect) {
        super.init(frame: frame)

        guard let url = "https://bitdash-a.akamaihd.net/content/MI201109210084_1/m3u8s/f08e80da-bf1d-4e3d-8899-f0f6155f6efa.m3u8".toURL else {
            return
        }

        let playerItem = AVPlayerItem(url: url)
        let queuePlayer = AVQueuePlayer(playerItem: playerItem)
        playerLayer.videoGravity = .resizeAspect
        playerLayer.player = queuePlayer

        layer.addSublayer(playerLayer)

        playerLooper = AVPlayerLooper(player: queuePlayer, templateItem: playerItem)

        queuePlayer.play()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func layoutSubviews() {
        super.layoutSubviews()

        playerLayer.frame = bounds
    }
}

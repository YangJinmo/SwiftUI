//
//  LoopingVideoPlayer.swift
//  Utils
//
//  Created by Jmy on 2023/07/02.
//

import AVKit
import SwiftUI

struct LoopingVideoPlayer: UIViewRepresentable {
    typealias UIViewType = UIView

    var url: URL

    func makeUIView(context: Context) -> UIView {
        url.absoluteString.log()

        return LoopingVideoPlayerUIView(url: url)
    }

    func updateUIView(_ uiView: UIViewType, context: Context) {
        url.absoluteString.log()

        guard let uiView = uiView as? LoopingVideoPlayerUIView, uiView.url != url else {
            return
        }

        uiView.url = url
    }
}

fileprivate final class LoopingVideoPlayerUIView: UIView {
    var url: URL {
        didSet {
            url.absoluteString.log()

            configure()
        }
    }

    fileprivate var playerLayer = AVPlayerLayer()
    fileprivate var playerLooper: AVPlayerLooper?

    init(url: URL) {
        self.url = url

        super.init(frame: .zero)

        configure()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    private func configure() {
        url.absoluteString.log()

        let playerItem = AVPlayerItem(url: url)
        let queuePlayer = AVQueuePlayer(playerItem: playerItem)
        queuePlayer.automaticallyWaitsToMinimizeStalling = true
        queuePlayer.playImmediately(atRate: 1)

        playerLayer.videoGravity = .resizeAspectFill
        playerLayer.player = queuePlayer

        layer.addSublayer(playerLayer)

        if let playerLooper = playerLooper {
            playerLooper.disableLooping()
        }

        playerLooper = AVPlayerLooper(player: queuePlayer, templateItem: playerItem)

        queuePlayer.play()
    }

    override func layoutSubviews() {
        super.layoutSubviews()

        playerLayer.frame = bounds
    }
}

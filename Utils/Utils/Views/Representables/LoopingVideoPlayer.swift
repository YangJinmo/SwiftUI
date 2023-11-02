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

    fileprivate var playerLayer: AVPlayerLayer?
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
        let player = AVQueuePlayer(playerItem: playerItem)
        player.automaticallyWaitsToMinimizeStalling = true
        player.playImmediately(atRate: 1)

        if playerLayer == nil {
            playerLayer = AVPlayerLayer(player: player)
            playerLayer?.videoGravity = .resizeAspectFill

            layer.addSublayer(playerLayer!)
        } else {
            playerLayer?.player = player
        }

        if let playerLooper = playerLooper {
            playerLooper.disableLooping()
        }

        playerLooper = AVPlayerLooper(player: player, templateItem: playerItem)

        player.play()
    }

    override func layoutSubviews() {
        super.layoutSubviews()

        playerLayer?.frame = bounds
    }
}

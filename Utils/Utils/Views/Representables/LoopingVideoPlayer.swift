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
    // @Binding var url: URL

    func makeUIView(context: Context) -> UIView {
        print("LoopingVideoPlayer makeUIView: \(url.absoluteString)")
        return LoopingVideoPlayerUIView(url: url)
    }

    func updateUIView(_ uiView: UIViewType, context: Context) {
        print("LoopingVideoPlayer updateUIView: \(url.absoluteString)")

        guard let uiView = uiView as? LoopingVideoPlayerUIView, uiView.url != url else {
            return
        }

        uiView.url = url
        // uiView.configurePlayerItem()
    }
}

fileprivate final class LoopingVideoPlayerUIView: UIView {
    var url: URL {
        didSet {
            print("LoopingVideoPlayer didSet: \(url.absoluteString)")
            configurePlayerItem()
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
        print("LoopingVideoPlayer configure: \(url.absoluteString)")

        let playerItem = AVPlayerItem(url: url)
        let queuePlayer = AVQueuePlayer(playerItem: playerItem)
        playerLayer.videoGravity = .resizeAspectFill
        playerLayer.player = queuePlayer

        layer.addSublayer(playerLayer)

        playerLooper = AVPlayerLooper(player: queuePlayer, templateItem: playerItem)

        queuePlayer.play()
    }

    private func configurePlayerItem() {
        let playerItem = AVPlayerItem(url: url)
        let queuePlayer = AVQueuePlayer(playerItem: playerItem)
        playerLayer.player = queuePlayer

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

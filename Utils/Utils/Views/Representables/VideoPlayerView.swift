//
//  VideoPlayerView.swift
//  Utils
//
//  Created by Jmy on 2023/10/30.
//
import AVKit
import SwiftUI

struct VideoPlayerView: View {
    var body: some View {
        VideoPlayerContainer(url: URL(string: "https://bitdash-a.akamaihd.net/content/sintel/hls/playlist.m3u8")!)
    }
}

struct VideoPlayerContainer: View {
    // The progress through the video, as a percentage (from 0 to 1)
    @State private var videoPos: Double = 0
    // The duration of the video in seconds
    @State private var videoDuration: Double = 0
    // Whether we're currently interacting with the seek bar or doing a seek
    @State private var seeking = false

    @State private var isPlaying = true
    @State private var currentTime: Float = 0.0
    @State private var playerPaused = true

    private let player: AVPlayer

    init(url: URL) {
        player = AVPlayer(url: url)
    }

    var body: some View {
        VStack {
            VideoPlayerRepresentable(isPlaying: $isPlaying, currentTime: $currentTime)
            Slider(value: $currentTime, in: 0 ... 1, step: 0.01, onEditingChanged: sliderEditingChanged)
            Button(action: {
                self.isPlaying.toggle()
            }) {
                Image(systemName: isPlaying ? "pause.fill" : "play.fill")
                    .font(.title)
            }
        }
    }

    private func pausePlayer(_ pause: Bool) {
        playerPaused = pause
        if playerPaused {
            player.pause()
        } else {
            player.play()
        }
    }

    private func sliderEditingChanged(editingStarted: Bool) {
        if editingStarted {
            // Set a flag stating that we're seeking so the slider doesn't
            // get updated by the periodic time observer on the player
            seeking = true
            pausePlayer(true)
        }

        // Do the seek if we're finished
        if !editingStarted {
            let targetTime = CMTime(seconds: videoPos * videoDuration,
                                    preferredTimescale: 600)
            player.seek(to: targetTime) { _ in
                // Now the seek is finished, resume normal operation
                self.seeking = false
                self.pausePlayer(false)
            }
        }
    }
}

struct VideoPlayerRepresentable: UIViewRepresentable {
    @Binding var isPlaying: Bool
    @Binding var currentTime: Float

    func makeUIView(context: Context) -> UIView {
        let playerView = VideoPlayerViewWrapper()
        playerView.isPlaying = isPlaying
        playerView.updateTime(currentTime)
        return playerView
    }

    func updateUIView(_ uiView: UIView, context: Context) {
        if let playerView = uiView as? VideoPlayerViewWrapper {
            playerView.isPlaying = isPlaying
            playerView.updateTime(currentTime)
        }
    }
}

class VideoPlayerViewWrapper: UIView {
    private var playerLayer: AVPlayerLayer?
    private var player: AVPlayer!
    private var playerItem: AVPlayerItem?

    var isPlaying: Bool = true {
        didSet {
            if isPlaying {
                player.play()
            } else {
                player.pause()
            }
        }
    }

    func updateTime(_ time: Float) {
        guard let playerItem = playerItem else { return }
        let seconds = CMTimeGetSeconds(playerItem.duration)
        let targetTime = CMTime(seconds: Double(time) * seconds, preferredTimescale: 600)
        player.seek(to: targetTime)
    }

    override init(frame: CGRect) {
        super.init(frame: frame)

        setupPlayer()
    }

    required init?(coder: NSCoder) {
        super.init(coder: coder)

        setupPlayer()
    }

    private func setupPlayer() {
        if playerLayer == nil, let url = URL(string: "https://bitdash-a.akamaihd.net/content/MI201109210084_1/m3u8s/f08e80da-bf1d-4e3d-8899-f0f6155f6efa.m3u8") {
            playerItem = AVPlayerItem(url: url)
            player = AVPlayer(playerItem: playerItem)
            playerLayer = AVPlayerLayer(player: player)
            playerLayer?.videoGravity = .resizeAspectFill
            layer.addSublayer(playerLayer!)
            player.play()
        }
    }

    override func layoutSubviews() {
        super.layoutSubviews()

        playerLayer?.frame = bounds
    }
}

#Preview {
    VideoPlayerView()
}

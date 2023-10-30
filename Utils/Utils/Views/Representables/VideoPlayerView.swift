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
        VideoPlayerContainer()
    }
}

struct VideoPlayerContainer: View {
    @Binding private(set) var videoPos: Double
    @Binding private(set) var videoDuration: Double
    @Binding private(set) var seeking: Bool

    @State private var isPlaying = true
    @State private var currentTime: Float = 0.0
    @State private var playerPaused = true
    
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

struct VideoPlayerView_Previews: PreviewProvider {
    static var previews: some View {
        VideoPlayerView()
    }
}

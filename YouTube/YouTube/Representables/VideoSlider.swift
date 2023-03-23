//
//  VideoSlider.swift
//  YouTube
//
//  Created by Jmy on 2023/03/22.
//

import AVKit
import SwiftUI
import UIKit

struct VideoSlider: UIViewRepresentable {
    @Binding var value: Float
    @Binding var player: AVPlayer
    @Binding var isPlaying: Bool

    func makeUIView(context: Context) -> UISlider {
        let slider = TapSlider()
        slider.minimumTrackTintColor = .red
        slider.maximumTrackTintColor = .gray
        slider.thumbTintColor = .red
        slider.value = value
        slider.addTarget(context.coordinator, action: #selector(context.coordinator.changed(slider:)), for: .valueChanged)
        return slider
    }

    func updateUIView(_ uiView: UISlider, context: Context) {
        uiView.value = value
    }

    func makeCoordinator() -> Coordinator {
        return VideoSlider.Coordinator(parrent1: self)
    }

    class Coordinator: NSObject {
        var parent: VideoSlider

        init(parrent1: VideoSlider) {
            parent = parrent1
        }

        @objc func changed(slider: UISlider) {
            if slider.isTracking {
                parent.player.pause()

                let sec = Double(slider.value * Float((parent.player.currentItem?.duration.seconds)!))

                parent.player.seek(to: CMTime(seconds: sec, preferredTimescale: 1))
            } else {
                let sec = Double(slider.value * Float((parent.player.currentItem?.duration.seconds)!))

                parent.player.seek(to: CMTime(seconds: sec, preferredTimescale: 1))

                if parent.isPlaying {
                    parent.player.play()
                }
            }
        }
    }
}

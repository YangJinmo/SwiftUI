//
//  ControllersView.swift
//  YouTube
//
//  Created by Jmy on 2023/03/22.
//

import AVKit
import SwiftUI

struct ControllersView: View {
    @Binding var player: AVPlayer
    @Binding var isPlaying: Bool
    @Binding var isShow: Bool
    @Binding var progress: Float

    var body: some View {
        ZStack {
            VStack {
                Spacer()

                HStack {
                    Button {
                        player.seek(to: CMTime(seconds: getSeconds() - 10, preferredTimescale: 1))
                    } label: {
                        Image(systemName: "backward.fill")
                            .font(.title)
                            .foregroundColor(.white)
                            .padding(20)
                    }

                    Spacer()

                    Button {
                        if isPlaying {
                            player.pause()
                            isPlaying = false
                        } else {
                            player.play()
                            isPlaying = true
                        }
                    } label: {
                        Image(systemName: isPlaying ? "pause.fill" : "play.fill")
                            .font(.title)
                            .foregroundColor(.white)
                            .padding(20)
                    }

                    Spacer()

                    Button {
                        player.seek(to: CMTime(seconds: getSeconds() + 10, preferredTimescale: 1))
                    } label: {
                        Image(systemName: "forward.fill")
                            .font(.title)
                            .foregroundColor(.white)
                            .padding(20)
                    }
                }

                Spacer()
            }
            .padding()
            .background(Color.black.opacity(0.4))
            .onTapGesture {
                withAnimation {
                    isShow = false
                }
            }
            .onAppear {
                player.addPeriodicTimeObserver(forInterval: CMTime(seconds: 1, preferredTimescale: 1), queue: .main) { _ in
                    progress = getSliderValue()

                    if progress == 1.0 {
                        isPlaying = false
                    }
                }
            }

            VStack {
                Spacer()

                VideoSlider(value: $progress, player: $player, isPlaying: $isPlaying)
                    .padding()
            }
        }
    }

    func getSliderValue() -> Float {
        return Float(player.currentTime().seconds / (player.currentItem?.duration.seconds)!)
    }

    func getSeconds() -> Double {
        return Double(Double(progress) * (player.currentItem?.duration.seconds)!)
    }
}

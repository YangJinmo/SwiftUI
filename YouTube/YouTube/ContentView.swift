//
//  ContentView.swift
//  YouTube
//
//  Created by Jmy on 2023/03/13.
//

import AVKit
import SwiftUI

struct ContentView: View {
    // "https://bitdash-a.akamaihd.net/content/MI201109210084_1/m3u8s/f08e80da-bf1d-4e3d-8899-f0f6155f6efa.m3u8"
    // "https://assets.afcdn.com/video49/20210722/v_645516.m3u8"
    // "https://storage.googleapis.com/gtv-videos-bucket/sample/BigBuckBunny.mp4"
    @State var player = AVPlayer(url: URL(string: "https://bitdash-a.akamaihd.net/content/MI201109210084_1/m3u8s/f08e80da-bf1d-4e3d-8899-f0f6155f6efa.m3u8")!)
    @State var isPlaying = false
    @State var showControls = false
    @State var value: Float = 0

    var body: some View {
        GeometryReader { proxy in
            VStack {
                ZStack {
                    VideoPlayer(player: $player)

                    if self.showControls {
                        Controls(
                            player: self.$player,
                            isPlaying: self.$isPlaying,
                            pannel: self.$showControls,
                            value: self.$value
                        )
                    }
                }
                // .frame(height: UIScreen.main.bounds.height / 3.5)
                .frame(height: UIDevice.current.orientation.isLandscape ? proxy.size.height : proxy.size.height / 3.5)
                .onTapGesture {
                    self.showControls = true
                }

                if !UIDevice.current.orientation.isLandscape {
                    GeometryReader { _ in
                        VStack {
                            Text("Custom Video Player")
                                .foregroundColor(.white)
                                .background(Color.black.ignoresSafeArea(.all))
                        }
                    }
                }
            }
            .background(Color.black.ignoresSafeArea(.all))
            .onAppear {
                self.player.play()
                self.isPlaying = true
            }
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}

struct Controls: View {
    @Binding var player: AVPlayer
    @Binding var isPlaying: Bool
    @Binding var pannel: Bool
    @Binding var value: Float

    var body: some View {
        VStack {
            Spacer()

            HStack {
                Button {
                    self.player.seek(to: CMTime(seconds: self.getSeconds() - 10, preferredTimescale: 1))
                } label: {
                    Image(systemName: "backward.fill")
                        .font(.title)
                        .foregroundColor(.white)
                        .padding(20)
                }

                Spacer()

                Button {
                    if self.isPlaying {
                        self.player.pause()
                        self.isPlaying = false
                    } else {
                        self.player.play()
                        self.isPlaying = true
                    }
//                    self.isPlaying.toggle()
                } label: {
                    Image(systemName: self.isPlaying ? "pause.fill" : "play.fill")
                        .font(.title)
                        .foregroundColor(.white)
                        .padding(20)
                }

                Spacer()

                Button {
                    self.player.seek(to: CMTime(seconds: self.getSeconds() + 10, preferredTimescale: 1))
                } label: {
                    Image(systemName: "forward.fill")
                        .font(.title)
                        .foregroundColor(.white)
                        .padding(20)
                }
            }

            Spacer()

            CustomProgressBar(value: self.$value, player: self.$player, isPlaying: self.$isPlaying)
        }
        .padding()
        .background(Color.black.opacity(0.4))
        .onTapGesture {
            self.pannel = false
        }
        .onAppear {
            self.player.addPeriodicTimeObserver(forInterval: CMTime(seconds: 1, preferredTimescale: 1), queue: .main) { _ in
                self.value = getSliderValue()

                if self.value == 1.0 {
                    self.isPlaying = false
                }
            }
        }
    }

    func getSliderValue() -> Float {
        return Float(player.currentTime().seconds / (player.currentItem?.duration.seconds)!)
    }

    func getSeconds() -> Double {
        return Double(Double(value) * (player.currentItem?.duration.seconds)!)
    }
}

struct CustomProgressBar: UIViewRepresentable {
    func makeCoordinator() -> Coordinator {
        return CustomProgressBar.Coordinator(parrent1: self)
    }

    @Binding var value: Float
    @Binding var player: AVPlayer
    @Binding var isPlaying: Bool

    func makeUIView(context: Context) -> UISlider {
        let slider = UISlider()
        slider.minimumTrackTintColor = .red
        slider.maximumTrackTintColor = .gray
        slider.thumbTintColor = .red
        slider.setThumbImage(UIImage(named: "thumb"), for: .normal)
        slider.value = value
        slider.addTarget(context.coordinator, action: #selector(context.coordinator.changed(slider:)), for: .valueChanged)
        return slider
    }

    func updateUIView(_ uiView: UISlider, context: Context) {
        uiView.value = value
    }

    class Coordinator: NSObject {
        var parent: CustomProgressBar

        init(parrent1: CustomProgressBar) {
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

class Host: UIHostingController<ContentView> {
    override var preferredStatusBarStyle: UIStatusBarStyle {
        return .lightContent
    }
}

struct VideoPlayer: UIViewControllerRepresentable {
    @Binding var player: AVPlayer

    func makeUIViewController(context: Context) -> AVPlayerViewController {
        let controller = AVPlayerViewController()
        controller.player = player
        controller.showsPlaybackControls = false
        controller.allowsVideoFrameAnalysis = false
        controller.videoGravity = .resize
        return controller
    }

    func updateUIViewController(_ playerViewController: AVPlayerViewController, context: Context) {
    }
}

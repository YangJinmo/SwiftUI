//
//  ContentView.swift
//  YouTube
//
//  Created by Jmy on 2023/03/13.
//

import AVKit
import SwiftUI

struct ContentView: View {
    @State var player = AVPlayer(url: URL(string: "https://assets.afcdn.com/video49/20210722/v_645516.m3u8")!)

    var body: some View {
        VStack {
            ZStack {
                VideoPlayer(player: $player)

                Controls()
            }
            .frame(height: UIScreen.main.bounds.height / 3.5)

            Spacer()
        }
        .background(Color.black.ignoresSafeArea())
        .onAppear {
            self.player.play()
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}

struct Controls: View {
    var body: some View {
        VStack {
            Spacer()

            HStack {
                Button {
                } label: {
                    Image(systemName: "backward.fill")
                        .font(.title)
                        .foregroundColor(.white)
                        .padding(20)
                }

                Spacer()

                Button {
                } label: {
                    Image(systemName: "play.fill")
                        .font(.title)
                        .foregroundColor(.white)
                        .padding(20)
                }

                Spacer()

                Button {
                } label: {
                    Image(systemName: "forward.fill")
                        .font(.title)
                        .foregroundColor(.white)
                        .padding(20)
                }
            }
        }
        .padding()
    }
}

struct VideoPlayer: UIViewControllerRepresentable {
    @Binding var player: AVPlayer

    func makeCoordinator() -> Coordinator {
        return Coordinator(parent: self)
    }

    func makeUIViewController(context: Context) -> AVPlayerViewController {
        let controller = AVPlayerViewController()
        controller.player = player
        controller.showsPlaybackControls = false
        return controller
    }

    func updateUIViewController(_ playerViewController: AVPlayerViewController, context: Context) {
        print("updateReel: \(player.currentItem?.url?.description ?? "")")
    }

    static func dismantleUIViewController(_ uiViewController: AVPlayerViewController, coordinator: Coordinator) {
        print("dismantleReel: \(coordinator.parent.player.currentItem?.url?.description ?? "")")
    }

    class Coordinator: NSObject {
        var parent: VideoPlayer

        init(parent: VideoPlayer) {
            self.parent = parent
        }

        @objc func restartPlayback() {
            parent.player.seek(to: .zero)
        }
    }
}

extension AVPlayerItem {
    var url: URL? {
        return (asset as? AVURLAsset)?.url
    }
}

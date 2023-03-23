//
//  ContentView.swift
//  YouTube
//
//  Created by Jmy on 2023/03/13.
//

import AVKit
import SwiftUI

// "https://bitdash-a.akamaihd.net/content/MI201109210084_1/m3u8s/f08e80da-bf1d-4e3d-8899-f0f6155f6efa.m3u8"
// "https://assets.afcdn.com/video49/20210722/v_645516.m3u8"
// "https://storage.googleapis.com/gtv-videos-bucket/sample/BigBuckBunny.mp4"
let urlString = "https://bitdash-a.akamaihd.net/content/MI201109210084_1/m3u8s/f08e80da-bf1d-4e3d-8899-f0f6155f6efa.m3u8"
let url = URL(string: urlString)!

struct ContentView: View {
    @State var player = AVPlayer(url: url)
    @State var isPlaying = false
    @State var isShowControllers = false
    @State var progress: Float = 0

    var body: some View {
        GeometryReader { proxy in
            VStack {
                ZStack {
                    VideoPlayer(player: $player)

                    if isShowControllers {
                        ControllersView(
                            player: $player,
                            isPlaying: $isPlaying,
                            isShow: $isShowControllers,
                            progress: $progress
                        )
                    }
                }
                .frame(
                    height: UIDevice.current.orientation.isLandscape
                        ? proxy.size.height
                        : proxy.size.height / 3.5
                )
                .onTapGesture {
                    withAnimation {
                        isShowControllers = true
                    }
                }

                if !UIDevice.current.orientation.isLandscape {
                    GeometryReader { proxy in
                        let _ = print("proxy.size: \(proxy.size)")

                        VStack(alignment: .leading, spacing: 8) {
                            Text("Title: Custom Video Player")
                                .foregroundColor(Color(UIColor.label))

                            Text("URL: \(urlString)")
                                .foregroundColor(Color(UIColor.secondaryLabel))

                            Text("proxy.size: \(proxy.size.width), \(proxy.size.height)")
                                .foregroundColor(Color(UIColor.tertiaryLabel))
                        }
                        .frame(maxWidth: .infinity, alignment: .leading)
                        .padding(16)
                    }
                }
            }
            .onAppear {
                player.play()
                isPlaying = true
            }
            .preferredColorScheme(.dark)
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}

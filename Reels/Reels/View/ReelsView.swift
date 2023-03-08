//
//  ReelsView.swift
//  Reels
//
//  Created by Jmy on 2023/03/08.
//

import AVKit
import SwiftUI

struct ReelsView: View {
    @State var currentReel = ""
    @State var reels = mediaFiles.map { mediaFile -> Reel in
        guard let url = mediaFile.url.toURL else {
            return Reel(player: AVPlayer(), mediaFile: mediaFile)
        }

        let player = AVPlayer(url: url)

        return Reel(player: player, mediaFile: mediaFile)
    }

    var body: some View {
        GeometryReader { proxy in
            let size = proxy.size

            TabView(selection: $currentReel) {
                ForEach($reels) { $reel in
                    ReelsPlayer(reel: $reel)
                        .frame(width: size.width)
                        .rotationEffect(.degrees(-90))
                        .ignoresSafeArea(.all, edges: .top)
                }
            }
            .rotationEffect(.degrees(90))
            .frame(width: size.height)
            .tabViewStyle(.page(indexDisplayMode: .never))
            .frame(width: size.width)
        }
        .ignoresSafeArea(.all, edges: .top)
        .background(Color.black.ignoresSafeArea())
    }
}

struct ReelsView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}

struct ReelsPlayer: View {
    @Binding var reel: Reel

    var body: some View {
        ZStack {
            if let player = reel.player {
                CustomVideoPlayer(player: player)

                HStack(alignment: .bottom) {
                    VStack(alignment: .leading, spacing: 10) {
                        HStack(spacing: 15) {
                            AsyncImage(url: URL(string: "https://i.ytimg.com/vi/Kv38mphgpqw/maxresdefault.jpg")) { phase in
                                switch phase {
                                case .empty:
                                    ProgressView()

                                case let .success(image):
                                    image.resizable()
                                        .aspectRatio(contentMode: .fill)
                                        .frame(width: 35, height: 35)
                                        .clipShape(Circle())

                                case .failure:
                                    Color
                                        .gray
                                        .opacity(0.75)
                                        .overlay {
                                            Image(systemName: "photo")
                                                .foregroundColor(.white)
                                                .font(.system(size: 24, weight: .bold))
                                                .transition(.opacity.combined(with: .scale))
                                        }

                                @unknown default:
                                    EmptyView()
                                }
                            }

                            Text("iJustine")
                                .font(.callout.bold())
                                .foregroundColor(.white)

                            Button {
                            } label: {
                                Text("Follow")
                                    .font(.caption.bold())
                                    .foregroundColor(.white)
                            }
                        }
                    }
                }
                .frame(maxHeight: .infinity, alignment: .bottom)
            }
        }
    }
}

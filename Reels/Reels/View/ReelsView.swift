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
    @State var reels = medias.map { media -> Reel in
        guard let url = media.url.toURL else {
            return Reel(player: AVPlayer(), media: media)
        }

        return Reel(player: AVPlayer(url: url), media: media)
    }

    var body: some View {
        GeometryReader { proxy in
            let size = proxy.size

            TabView(selection: $currentReel) {
                ForEach($reels) { $reel in
                    ReelsPlayerView(reel: $reel, currentReel: $currentReel)
                        .frame(width: size.width)
                        .rotationEffect(.degrees(-90))
                        .ignoresSafeArea(.all, edges: .top)
                        .tag(reel.id)
                }
            }
            .rotationEffect(.degrees(90))
            .frame(width: size.height)
            .tabViewStyle(.page(indexDisplayMode: .never))
            .frame(width: size.width)
        }
        .ignoresSafeArea(.all, edges: .top)
        .background(Color.black.ignoresSafeArea())
        .onAppear {
            if let reel = reels.first {
                currentReel = reel.id
            }

            print("onAppear - currentReel: \(currentReel)")
        }
    }
}

struct ReelsView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}

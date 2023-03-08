//
//  ReelsView.swift
//  Reels
//
//  Created by Jmy on 2023/03/08.
//

import SwiftUI
import AVKit

struct ReelsView: View {
    @State var currentReel = ""
    @State var reels = mediaFiles.map { mediaFile -> Reel in
        let url = Bundle.main.path(forResource: mediaFile.url, ofType: "mp4") ?? ""
        let player = AVPlayer(url: URL(fileURLWithPath: url))
        
        return Reel(player: player, mediaFile: mediaFile)
    }

    var body: some View {
        GeometryReader { proxy in
            let size = proxy.size

            TabView(selection: $currentReel) {
                ForEach($reels) { $reel in
                    ReelsPlayer(reel: $reel)
                    
                    VStack {
                        Text("Hello")
                        Spacer()
                        Text("Hello")
                            .frame(maxWidth: .infinity, alignment: .trailing)
                    }
                    .frame(width: size.width)
                    .padding()
                    .rotationEffect(.degrees(-90))
                }
            }
            .rotationEffect(.degrees(90))
            .frame(width: size.height)
            .tabViewStyle(.page(indexDisplayMode: .never))
            .frame(width: size.width)
        }
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
            
        }
    }
}

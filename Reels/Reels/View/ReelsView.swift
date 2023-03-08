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
                    ReelsPlayer(reel: $reel, currentReel: $currentReel)
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
        // Setting inital reel
        .onAppear {
            currentReel = reels.first?.id ?? ""
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
    @Binding var currentReel: String

    @State var showMore = false
    @State var isMuted = false
    @State var volumeAnimation = false

    var body: some View {
        ZStack {
            if let player = reel.player {
                CustomVideoPlayer(player: player)

                // Playing Video Based On Offset

                GeometryReader { proxy -> Color in
                    let minY = proxy.frame(in: .global).minY
                    let size = proxy.size

                    // since we have many card and offset goes beyond
                    // so it starts playing the below videos
                    // to avoid this checking the current one with current real id
                    DispatchQueue.main.async {
                        if -minY < (size.height / 2) && minY < (size.height / 2) && currentReel == reel.id {
                            player.play()
                        } else {
                            player.pause()
                        }
                    }

                    return Color.clear
                }

                // Volume control
                Color.black
                    .opacity(0.01)
                    .frame(width: 150, height: 150)
                    .onTapGesture {
                        if volumeAnimation {
                            return
                        }

                        isMuted.toggle()

                        player.isMuted = isMuted

                        withAnimation {
                            volumeAnimation.toggle()
                        }

                        // Closing animation after 0.8 sec

                        DispatchQueue.main.asyncAfter(deadline: .now() + 0.8) {
                            withAnimation {
                                volumeAnimation.toggle()
                            }
                        }
                    }

                // Dimming background when showing more content
                Color.black.opacity(showMore ? 0.35 : 0)
                    .onTapGesture {
                        withAnimation {
                            showMore.toggle()
                        }
                    }
                VStack(spacing: 25) {
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

                            ZStack {
                                if showMore {
                                    ScrollView(.vertical, showsIndicators: false) {
                                        Text(reel.mediaFile.title + sampleText)
                                            .font(.callout)
                                            .fontWeight(.semibold)
                                    }
                                    .frame(height: 120)
                                    .onTapGesture {
                                        withAnimation {
                                            showMore.toggle()
                                        }
                                    }
                                } else {
                                    Button {
                                        withAnimation {
                                            showMore.toggle()
                                        }
                                    } label: {
                                        HStack {
                                            Text(reel.mediaFile.title)
                                                .font(.callout)
                                                .fontWeight(.semibold)
                                                .lineLimit(1)

                                            Text("more")
                                                .font(.callout.bold())
                                        }
                                        .padding(.top, 6)
                                        .frame(maxWidth: .infinity, alignment: .leading)
                                    }
                                }
                            }
                        }

                        Spacer(minLength: 20)

                        ActionButton(reel: reel)
                    }

                    HStack {
                        Text("A Sky full of Stars")
                            .font(.caption)
                            .fontWeight(.semibold)

                        Spacer(minLength: 20)

                        AsyncImage(url: URL(string: "https://upload.wikimedia.org/wikipedia/en/8/8d/Coldplay_-_A_Sky_Full_of_Stars_%28Single%29.png")) { phase in
                            switch phase {
                            case .empty:
                                ProgressView()

                            case let .success(image):
                                image.resizable()
                                    .aspectRatio(contentMode: .fill)
                                    .frame(width: 30, height: 30)
                                    .cornerRadius(6)
                                    .background(
                                        RoundedRectangle(cornerRadius: 6)
                                            .stroke(Color.white, lineWidth: 3)
                                    )
                                    .offset(x: -5)

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
                    }
                }
                .padding(.horizontal)
                .padding(.bottom, 20)
                .foregroundColor(.white)
                .frame(maxHeight: .infinity, alignment: .bottom)

                Image(systemName: isMuted ? "speaker.slash.fill" : "speaker.wave.2.fill")
                    .font(.title)
                    .foregroundColor(.white)
                    .padding()
                    .background(.secondary)
                    .clipShape(Circle())
                    .foregroundStyle(.black)
                    .opacity(volumeAnimation ? 1 : 0)
            }
        }
    }
}

struct ActionButton: View {
    var reel: Reel

    var body: some View {
        VStack(spacing: 25) {
            Button {
            } label: {
                VStack(spacing: 10) {
                    Image(systemName: "suit.heart")
                        .font(.title)

                    Text("233K")
                        .font(.caption.bold())
                }
            }

            Button {
            } label: {
                VStack(spacing: 10) {
                    Image(systemName: "bubble.right")
                        .font(.title)

                    Text("120")
                        .font(.caption.bold())
                }
            }

            Button {
            } label: {
                VStack(spacing: 10) {
                    Image(systemName: "paperplane")
                        .font(.title)
                }
            }

            Button {
            } label: {
                VStack(spacing: 10) {
                    Image(systemName: "ellipsis")
                        .font(.title)
                }
            }
        }
    }
}

var sampleText = "A barking dog never bites, A big fish in a small pond, No pain No gain, A good medicine tastes bitter, It never rains but it pours, A bad workman blames his tools"

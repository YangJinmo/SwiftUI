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

        let playerItem = AVPlayerItem(url: url)
        playerItem.preferredForwardBufferDuration = 1

        let player = AVPlayer(playerItem: playerItem)

        return Reel(player: player, media: media)
    }

    private let audioSession = AVAudioSession.sharedInstance()

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
        .onAppear {
            print("onAppear")

            if let reel = reels.first {
                currentReel = reel.id
                print("currentReel: \(reel.media.url)")
            }
        }
    }
}

struct ReelsView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}

struct ReelsPlayer: View {
    @Environment(\.scenePhase) var scenePhase

    @Binding var reel: Reel
    @Binding var currentReel: String

    @State var showMore = false
    @State var isFollow = false
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
                .onChange(of: scenePhase) { newPhase in
                    print("newPhase: \(newPhase)")

                    DispatchQueue.main.async {
                        if newPhase == .active {
                            player.play()
                        } else {
                            player.pause()
                        }
                    }
                }

                LinearGradient(
                    gradient: Gradient(
                        colors: [
                            Color.black.opacity(0.1),
                            Color.black.opacity(0),
                            Color.black.opacity(0.4),
                        ]
                    ),
                    startPoint: .top,
                    endPoint: .bottom
                )

                // Volume control
                Color.black.opacity(0.01)
                    .frame(
                        width: UIScreen.main.bounds.width - 120,
                        height: UIScreen.main.bounds.height - 320
                    )
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
//                    .border(.red)

                // Dimming background when showing more content
                Color.black.opacity(showMore ? 0.35 : 0)
                    .onTapGesture {
                        withAnimation {
                            showMore.toggle()
                        }
                    }

                VStack {
                    HStack(alignment: .bottom) {
                        VStack(alignment: .leading, spacing: 8) {
                            HStack(spacing: 12) {
                                let urlString = "https://img.kpopmap.com/680x384/2022/07/iu-concert_cover-image.jpg"
                                let size: CGFloat = 32

                                AsyncImage(url: URL(string: urlString)) { phase in
                                    switch phase {
                                    case .empty:
                                        ProgressView()
                                            .scaleEffect(1, anchor: .center)
                                            .font(.system(size: 8))
                                            .frame(width: size, height: size)
                                            .clipShape(Circle())
                                            .transition(.opacity.combined(with: .scale))
                                            .onTapGesture {
                                                print(urlString)
                                            }

                                    case let .success(image):
                                        image.resizable()
                                            .aspectRatio(contentMode: .fill)
                                            .frame(width: size, height: size)
                                            .clipShape(Circle())
                                            .transition(.opacity.combined(with: .scale))
                                            .onTapGesture {
                                                print(urlString)
                                            }
                                            .onTapGesture {
                                                print(urlString)
                                            }

                                    case .failure:
                                        Color.gray.opacity(0.75)
                                            .frame(width: size, height: size)
                                            .transition(.opacity.combined(with: .scale))
                                            .overlay {
                                                Image(systemName: "photo")
                                                    .foregroundColor(.white)
                                                    .font(.system(size: 24, weight: .bold))
                                                    .frame(width: size, height: size)
                                                    .clipShape(Circle())
                                                    .transition(.opacity.combined(with: .scale))
                                            }
                                            .onTapGesture {
                                                print(urlString)
                                            }

                                    @unknown default:
                                        EmptyView()
                                    }
                                }

                                Text("avantgardey_")
                                    .font(.system(size: 14, weight: .semibold))
                                    .foregroundColor(.white)

                                Button {
                                    isFollow.toggle()
                                } label: {
                                    Text(isFollow ? "팔로잉" : "팔로우")
                                        .font(.system(size: 14, weight: .semibold))
                                        .foregroundColor(.white)
                                        .padding(.vertical, 3)
                                        .padding(.horizontal, 8)
                                        .cornerRadius(6)
                                        .background(
                                            RoundedRectangle(cornerRadius: 6)
                                                .stroke(Color.white.opacity(0.4), lineWidth: 1)
                                        )
                                }
                            }

                            ZStack {
                                if showMore {
                                    // No issue in this case
//                                    Text(reel.media.title + sampleText)
//                                        .font(.system(size: 14))
//                                        .frame(maxWidth: .infinity, alignment: .leading)
//                                        .onTapGesture {
//                                            withAnimation {
//                                                showMore.toggle()
//                                            }
//                                        }
//                                        .border(.red)

                                    // TODO: An issue where the right action button moves
                                    ScrollView(.vertical, showsIndicators: false) {
                                        Text(reel.media.title + sampleText)
                                            .font(.system(size: 14))
                                            .frame(maxWidth: .infinity, alignment: .leading)
                                            .onTapGesture {
                                                withAnimation {
                                                    showMore.toggle()
                                                }
                                            }
//                                            .border(.red)
                                    }
                                    .frame(height: 320)
//                                    .border(.red)

                                } else {
                                    Button {
                                        withAnimation {
                                            showMore.toggle()
                                        }
                                    } label: {
                                        HStack(spacing: 4) {
                                            Text(reel.media.title)
                                                .font(.system(size: 14))
                                                .lineLimit(1)

                                            Text("...")
                                                .font(.system(size: 14))
                                                .foregroundColor(Color.white.opacity(0.8))
                                        }
                                        .frame(maxWidth: .infinity, alignment: .leading)
                                    }
//                                    .border(.red)
                                }
                            }
                            .padding(.top, 4)
                        }

                        Spacer(minLength: 20)

                        ActionButton(reel: reel)
                    }

                    HStack {
                        Image(systemName: "music.note")
                            .font(.system(size: 12, weight: .regular))

                        Text("threesmallfriends · 원본 오디오")
                            .font(.system(size: 14, weight: .regular))

                        Spacer(minLength: 20)

                        let urlString = "https://pbs.twimg.com/media/EzzGJeNWEAIQZ9F?format=jpg&name=large"
                        let size: CGFloat = 24

                        AsyncImage(url: URL(string: urlString)) { phase in
                            switch phase {
                            case .empty:
                                ProgressView()
                                    .scaleEffect(0.5, anchor: .center)
                                    .frame(width: size, height: size)
                                    .cornerRadius(6)
                                    .background(
                                        RoundedRectangle(cornerRadius: 6)
                                            .stroke(Color.white, lineWidth: 3)
                                    )
                                    .offset(x: -6)
                                    .transition(.opacity.combined(with: .scale))
                                    .onTapGesture {
                                        print(urlString)
                                    }

                            case let .success(image):
                                image.resizable()
                                    .aspectRatio(contentMode: .fill)
                                    .frame(width: size, height: size)
                                    .cornerRadius(6)
                                    .background(
                                        RoundedRectangle(cornerRadius: 6)
                                            .stroke(Color.white, lineWidth: 3)
                                    )
                                    .offset(x: -6)
                                    .transition(.opacity.combined(with: .scale))
                                    .onTapGesture {
                                        print(urlString)
                                    }

                            case .failure:
                                Color.gray.opacity(0.75)
                                    .frame(width: size, height: size)
                                    .transition(.opacity.combined(with: .scale))
                                    .overlay {
                                        Image(systemName: "photo")
                                            .foregroundColor(.white)
                                            .font(.system(size: 24, weight: .bold))
                                            .frame(width: size, height: size)
                                            .cornerRadius(6)
                                            .background(
                                                RoundedRectangle(cornerRadius: 6)
                                                    .stroke(Color.white, lineWidth: 3)
                                            )
                                            .offset(x: -6)
                                            .transition(.opacity.combined(with: .scale))
                                    }
                                    .onTapGesture {
                                        print(urlString)
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
        .onDisappear {
            print("onDisappear")

            DispatchQueue.main.async {
                reel.player?.pause()
            }
        }
    }
}

struct ActionButton: View {
    var reel: Reel

    var body: some View {
        VStack(spacing: 24) {
            Button {
            } label: {
                VStack(spacing: 8) {
                    Image(systemName: "suit.heart")
                        .font(.title)
                        .frame(width: 28, height: 28)

                    Text("13.9만")
                        .font(.footnote.bold())
                }
            }
//            .border(.white)

            Button {
            } label: {
                VStack(spacing: 8) {
                    Image(systemName: "bubble.right")
                        .font(.title)
                        .frame(width: 28, height: 28)

                    Text("2,545")
                        .font(.footnote.bold())
                }
            }
//            .border(.white)

            Button {
            } label: {
                VStack(spacing: 8) {
                    Image(systemName: "paperplane")
                        .font(.title)
                        .frame(width: 28, height: 28)
                }
            }
//            .border(.white)

            Button {
            } label: {
                VStack(spacing: 8) {
                    Image(systemName: "ellipsis")
                        .font(.callout)
                        .frame(width: 28, height: 32)
                        .offset(y: -5)
                }
            }
//            .border(.white)
        }
    }
}

var sampleText = " A barking dog never bites, A big fish in a small pond, No pain No gain, A good medicine tastes bitter, It never rains but it pours, A bad workman blames his tools, A barking dog never bites, A big fish in a small pond, No pain No gain, A good medicine tastes bitter, It never rains but it pours, A bad workman blames his tools, A barking dog never bites, A big fish in a small pond, No pain No gain, A good medicine tastes bitter, It never rains but it pours, A bad workman blames his tools, A barking dog never bites, A big fish in a small pond, No pain No gain, A good medicine tastes bitter, It never rains but it pours, A bad workman blames his tools, A barking dog never bites, A big fish in a small pond, No pain No gain, A good medicine tastes bitter, It never rains but it pours, A bad workman blames his tools.\n\n#bad #workman #blames #bad #workman #blames"

/*
 | Style        | Font          | Size |
 | ------------ | ------------- | ---- |
 | .largeTitle  | SFUI-Regular  | 34.0 |
 | .title1      | SFUI-Regular  | 28.0 |
 | .title2      | SFUI-Regular  | 22.0 |
 | .title3      | SFUI-Regular  | 20.0 |
 | .headline    | SFUI-Semibold | 17.0 |
 | .callout     | SFUI-Regular  | 16.0 |
 | .subheadline | SFUI-Regular  | 15.0 |
 | .body        | SFUI-Regular  | 17.0 |
 | .footnote    | SFUI-Regular  | 13.0 |
 | .caption1    | SFUI-Regular  | 12.0 |
 | .caption2    | SFUI-Regular  | 11.0 |
 */

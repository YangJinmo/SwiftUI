//
//  ContentView.swift
//  VideoPlayers
//
//  Created by Jmy on 2023/04/09.
//

import SwiftUI

struct ContentView: View {
    @StateObject private var viewModel = VideoPlayerViewModel()

    var body: some View {
        ScrollView(.vertical) {
            LazyVStack(spacing: 0) {
                ForEach(videos) { video in
                    GeometryReader { geometry in
                        VStack {
                            Spacer()
                            if let player = viewModel.currentPlayer, viewModel.currentVideo?.id == video.id {
                                VideoPlayerView(player: player)
                                    .aspectRatio(16 / 9, contentMode: .fit)
                                    .onChange(of: geometry.frame(in: .global).minY) { minY in
                                        if -minY < (geometry.size.height / 2) && minY < (geometry.size.height / 2) {
                                            viewModel.playVideo(video: video)
                                        } else {
                                            viewModel.pauseVideo()
                                        }
                                    }
                            } else {
                                Color.black
                                    .aspectRatio(16 / 9, contentMode: .fit)
                                    .onAppear {
                                        print("onAppear")
                                        viewModel.playVideo(video: video)
                                    }
                                    .onTapGesture {
                                        print("onTapGesture")
                                        viewModel.playVideo(video: video)
                                    }
                            }
                            Spacer()
                        }
                    }
                    .frame(height: UIScreen.main.bounds.height)
                }
            }
            .onAppear {
                UIScrollView.appearance().isPagingEnabled = true
            }
            .onDisappear {
                UIScrollView.appearance().isPagingEnabled = false
            }
            .ignoresSafeArea()
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}

struct Video: Identifiable, Hashable {
    let id: UUID
    let url: URL
}

import AVKit
import Combine

class VideoPlayerViewModel: ObservableObject {
    @Published private(set) var currentPlayer: AVPlayer?
    private(set) var currentVideo: Video?

    func playVideo(video: Video) {
        print("playVideo")

        if currentVideo?.id != video.id {
            currentPlayer?.pause()
            currentPlayer = AVPlayer(url: video.url)
            currentVideo = video
        }
        currentPlayer?.play()
    }

    func pauseVideo() {
        print("pauseVideo")

        currentPlayer?.pause()
    }

    func stopVideo() {
        print("stopVideo")

        currentPlayer?.pause()
        currentPlayer = nil
        currentVideo = nil
    }
}

import AVFoundation
import AVKit
import SwiftUI

struct VideoPlayerView: UIViewRepresentable {
    let player: AVPlayer

    func makeUIView(context: Context) -> UIView {
        let playerLayerView = PlayerLayerView()
        playerLayerView.player = player
        return playerLayerView
    }

    func updateUIView(_ uiView: UIView, context: Context) {
        let playerLayerView = uiView as! PlayerLayerView
        playerLayerView.player = player
    }

    class PlayerLayerView: UIView {
        override class var layerClass: AnyClass {
            return AVPlayerLayer.self
        }

        var player: AVPlayer? {
            get {
                return (layer as! AVPlayerLayer).player
            }
            set {
                (layer as! AVPlayerLayer).player = newValue
            }
        }
    }
}

class VideoPlayerViewModel2: ObservableObject {
    @Published var currentPlayer: AVPlayer?
    @Published var currentVideo: Video?
    @Published var isPlaying = false

    private var players: [AVPlayer] = []
    private var currentVideoIndex: Int?

    func playVideo(video: Video) {
        if currentVideo?.id == video.id {
            // 이미 선택된 비디오인 경우
            currentPlayer?.play()
            isPlaying = true
        } else {
            // 새 비디오를 선택하고 재생
            currentPlayer = AVPlayer(url: video.url)
            currentPlayer?.play()
            isPlaying = true
            currentVideo = video
        }
    }

    func playVideo(withURL url: URL) {
        if let index = players.firstIndex(where: { $0.currentItem?.asset as? AVURLAsset == AVURLAsset(url: url) }) {
            // 기존 플레이어 사용
            let player = players.remove(at: index)
            currentPlayer = player
            currentVideoIndex = index
            player.play()
        } else {
            // 새 플레이어 생성
            let player = AVPlayer(url: url)
            currentPlayer = player
            currentVideoIndex = players.count
            players.append(player)
            player.play()
        }
        isPlaying = true
    }

    func pauseVideo() {
        guard let player = currentPlayer else { return }
        player.pause()
        isPlaying = false
    }

    func stopVideo() {
        guard let player = currentPlayer else { return }
        player.pause()
        player.seek(to: .zero)
        currentPlayer = nil
        currentVideoIndex = nil
        isPlaying = false
    }
}

struct ContentView2: View {
    @StateObject private var viewModel = VideoPlayerViewModel()

    private let videos: [Video] = [
        Video(id: UUID(), url: URL(string: "https://commondatastorage.googleapis.com/gtv-videos-bucket/sample/BigBuckBunny.mp4")!),
        Video(id: UUID(), url: URL(string: "https://commondatastorage.googleapis.com/gtv-videos-bucket/sample/BigBuckBunny.mp4")!),
        Video(id: UUID(), url: URL(string: "https://commondatastorage.googleapis.com/gtv-videos-bucket/sample/BigBuckBunny.mp4")!),
        Video(id: UUID(), url: URL(string: "https://commondatastorage.googleapis.com/gtv-videos-bucket/sample/BigBuckBunny.mp4")!),
    ]

    var body: some View {
        ScrollView(.vertical) {
            VStack(spacing: 0) {
                ForEach(videos) { video in
                    GeometryReader { geometry in
                        VStack {
                            Spacer()

                            if let player = viewModel.currentPlayer, viewModel.currentVideo?.id == video.id {
                                VideoPlayerView(player: player)
                                    .aspectRatio(16 / 9, contentMode: .fit)
                                    .onChange(of: geometry.frame(in: .global).minY) { minY in
                                        if minY >= -50 && minY <= 50 {
                                            viewModel.playVideo(video: video)
                                        } else {
                                            viewModel.pauseVideo()
                                        }
                                    }
                            } else {
                                Color.black
                                    .aspectRatio(16 / 9, contentMode: .fit)
                                    .onTapGesture {
                                        print("onTapGesture")
                                        viewModel.playVideo(video: video)
                                    }
                            }

                            Spacer()
                        }
                    }
                    .frame(height: UIScreen.main.bounds.height)
                }
            }
            .onAppear {
                UIScrollView.appearance().isPagingEnabled = true
            }
            .onDisappear {
                UIScrollView.appearance().isPagingEnabled = false
            }
            .ignoresSafeArea()
        }
    }
}

struct PagingScrollView<Content: View>: UIViewRepresentable {
    var content: Content

    init(@ViewBuilder content: () -> Content) {
        self.content = content()
    }

    func makeCoordinator() -> Coordinator {
        Coordinator(self)
    }

    func makeUIView(context: Context) -> UIScrollView {
        let scrollView = UIScrollView()
        scrollView.isPagingEnabled = true
        scrollView.showsVerticalScrollIndicator = false
        scrollView.bounces = false
        scrollView.delegate = context.coordinator

        let hostView = UIHostingController(rootView: content)
        hostView.view.translatesAutoresizingMaskIntoConstraints = false
        scrollView.addSubview(hostView.view)

        NSLayoutConstraint.activate([
            hostView.view.leadingAnchor.constraint(equalTo: scrollView.leadingAnchor),
            hostView.view.trailingAnchor.constraint(equalTo: scrollView.trailingAnchor),
            hostView.view.topAnchor.constraint(equalTo: scrollView.topAnchor),
            hostView.view.bottomAnchor.constraint(equalTo: scrollView.bottomAnchor),
            hostView.view.widthAnchor.constraint(equalTo: scrollView.widthAnchor),
        ])

        return scrollView
    }

    func updateUIView(_ uiView: UIScrollView, context: Context) {}

    class Coordinator: NSObject, UIScrollViewDelegate {
        var parent: PagingScrollView

        init(_ parent: PagingScrollView) {
            self.parent = parent
        }
    }
}

struct ContentView3: View {
    @StateObject private var viewModel = VideoPlayerViewModel2()

    private let videos: [Video] = [
        Video(id: UUID(), url: URL(string: "https://commondatastorage.googleapis.com/gtv-videos-bucket/sample/BigBuckBunny.mp4")!),
        Video(id: UUID(), url: URL(string: "https://commondatastorage.googleapis.com/gtv-videos-bucket/sample/BigBuckBunny.mp4")!),
        // 더 많은 비디오 URL을 추가하세요.
    ]

    var body: some View {
        VStack {
            if let player = viewModel.currentPlayer {
                VideoPlayerView(player: player)
                    .aspectRatio(16 / 9, contentMode: .fit)
            }

            HStack {
                Button(viewModel.isPlaying ? "일시정지" : "재생") {
                    let url = URL(string: "https://commondatastorage.googleapis.com/gtv-videos-bucket/sample/BigBuckBunny.mp4")!
                    if viewModel.isPlaying {
                        viewModel.pauseVideo()
                    } else {
                        viewModel.playVideo(withURL: url)
                    }
                }

                Button("중지") {
                    viewModel.stopVideo()
                }
            }
        }
    }
}

struct ContentView4: View {
    @StateObject private var viewModel = VideoPlayerViewModel()

    var body: some View {
        ScrollView(.vertical, showsIndicators: false) {
            LazyVStack(spacing: 0) {
                ForEach(Array(0 ... videoss.count - 1), id: \.self) { row in
                    ScrollView(.horizontal, showsIndicators: false) {
                        LazyHStack(spacing: 0) {
                            ForEach(videoss[row]) { video in
                                if let player = viewModel.currentPlayer, viewModel.currentVideo?.id == video.id {
                                    VideoPlayerView(player: player)
                                        .tag(video.id)
                                        .frame(
                                            width: UIScreen.main.bounds.width,
                                            height: UIScreen.main.bounds.height
                                        )
                                        .onAppear {
                                            print("onAppear row: \(row)")
                                            viewModel.playVideo(video: video)
                                        }
                                        .onDisappear {
                                            print("onDisappear row: \(row)")
                                        }
                                        .border(.red)
                                } else {
                                    Color.yellow
                                        .frame(
                                            width: UIScreen.main.bounds.width,
                                            height: UIScreen.main.bounds.height
                                        )
                                        .onAppear {
                                            print("onAppear")
                                            viewModel.playVideo(video: video)
                                        }
                                        .onTapGesture {
                                            print("onTapGesture")
                                            viewModel.playVideo(video: video)
                                        }
                                }
                            }
                        }
                    }
                }
            }
            .onAppear {
                UIScrollView.appearance().isPagingEnabled = true
            }
            .onDisappear {
                UIScrollView.appearance().isPagingEnabled = false
            }
            .ignoresSafeArea()
        }
    }
}

let videoss: [[Video]] = [
    [Video(id: UUID(), url: URL(string: "https://commondatastorage.googleapis.com/gtv-videos-bucket/sample/BigBuckBunny.mp4")!)],
    [Video(id: UUID(), url: URL(string: "https://commondatastorage.googleapis.com/gtv-videos-bucket/sample/BigBuckBunny.mp4")!)],
    [Video(id: UUID(), url: URL(string: "https://commondatastorage.googleapis.com/gtv-videos-bucket/sample/BigBuckBunny.mp4")!)],
    [Video(id: UUID(), url: URL(string: "https://commondatastorage.googleapis.com/gtv-videos-bucket/sample/BigBuckBunny.mp4")!)],
    [Video(id: UUID(), url: URL(string: "https://commondatastorage.googleapis.com/gtv-videos-bucket/sample/BigBuckBunny.mp4")!)],
    [Video(id: UUID(), url: URL(string: "https://commondatastorage.googleapis.com/gtv-videos-bucket/sample/BigBuckBunny.mp4")!)],
    [Video(id: UUID(), url: URL(string: "https://commondatastorage.googleapis.com/gtv-videos-bucket/sample/BigBuckBunny.mp4")!)],
    [Video(id: UUID(), url: URL(string: "https://commondatastorage.googleapis.com/gtv-videos-bucket/sample/BigBuckBunny.mp4")!)],
    [Video(id: UUID(), url: URL(string: "https://commondatastorage.googleapis.com/gtv-videos-bucket/sample/BigBuckBunny.mp4")!)],
    [Video(id: UUID(), url: URL(string: "https://commondatastorage.googleapis.com/gtv-videos-bucket/sample/BigBuckBunny.mp4")!)],
    [Video(id: UUID(), url: URL(string: "https://commondatastorage.googleapis.com/gtv-videos-bucket/sample/BigBuckBunny.mp4")!)],
    [Video(id: UUID(), url: URL(string: "https://commondatastorage.googleapis.com/gtv-videos-bucket/sample/BigBuckBunny.mp4")!)],
    [Video(id: UUID(), url: URL(string: "https://commondatastorage.googleapis.com/gtv-videos-bucket/sample/BigBuckBunny.mp4")!)],
    [Video(id: UUID(), url: URL(string: "https://commondatastorage.googleapis.com/gtv-videos-bucket/sample/BigBuckBunny.mp4")!)],
    [Video(id: UUID(), url: URL(string: "https://commondatastorage.googleapis.com/gtv-videos-bucket/sample/BigBuckBunny.mp4")!)],
    [Video(id: UUID(), url: URL(string: "https://commondatastorage.googleapis.com/gtv-videos-bucket/sample/BigBuckBunny.mp4")!)],
    [Video(id: UUID(), url: URL(string: "https://commondatastorage.googleapis.com/gtv-videos-bucket/sample/BigBuckBunny.mp4")!)],
    [Video(id: UUID(), url: URL(string: "https://commondatastorage.googleapis.com/gtv-videos-bucket/sample/BigBuckBunny.mp4")!)],
    [Video(id: UUID(), url: URL(string: "https://commondatastorage.googleapis.com/gtv-videos-bucket/sample/BigBuckBunny.mp4")!)],
    [Video(id: UUID(), url: URL(string: "https://commondatastorage.googleapis.com/gtv-videos-bucket/sample/BigBuckBunny.mp4")!)],
    [Video(id: UUID(), url: URL(string: "https://commondatastorage.googleapis.com/gtv-videos-bucket/sample/BigBuckBunny.mp4")!)],
    [Video(id: UUID(), url: URL(string: "https://commondatastorage.googleapis.com/gtv-videos-bucket/sample/BigBuckBunny.mp4")!)],
    [Video(id: UUID(), url: URL(string: "https://commondatastorage.googleapis.com/gtv-videos-bucket/sample/BigBuckBunny.mp4")!)],
    [Video(id: UUID(), url: URL(string: "https://commondatastorage.googleapis.com/gtv-videos-bucket/sample/BigBuckBunny.mp4")!)],
    [Video(id: UUID(), url: URL(string: "https://commondatastorage.googleapis.com/gtv-videos-bucket/sample/BigBuckBunny.mp4")!)],
    [Video(id: UUID(), url: URL(string: "https://commondatastorage.googleapis.com/gtv-videos-bucket/sample/BigBuckBunny.mp4")!)],
    [Video(id: UUID(), url: URL(string: "https://commondatastorage.googleapis.com/gtv-videos-bucket/sample/BigBuckBunny.mp4")!)],
    [Video(id: UUID(), url: URL(string: "https://commondatastorage.googleapis.com/gtv-videos-bucket/sample/BigBuckBunny.mp4")!)],
    [Video(id: UUID(), url: URL(string: "https://commondatastorage.googleapis.com/gtv-videos-bucket/sample/BigBuckBunny.mp4")!)],
    [Video(id: UUID(), url: URL(string: "https://commondatastorage.googleapis.com/gtv-videos-bucket/sample/BigBuckBunny.mp4")!)],
    [Video(id: UUID(), url: URL(string: "https://commondatastorage.googleapis.com/gtv-videos-bucket/sample/BigBuckBunny.mp4")!)],
    [Video(id: UUID(), url: URL(string: "https://commondatastorage.googleapis.com/gtv-videos-bucket/sample/BigBuckBunny.mp4")!)],
    [Video(id: UUID(), url: URL(string: "https://commondatastorage.googleapis.com/gtv-videos-bucket/sample/BigBuckBunny.mp4")!)],
    [Video(id: UUID(), url: URL(string: "https://commondatastorage.googleapis.com/gtv-videos-bucket/sample/BigBuckBunny.mp4")!)],
    [Video(id: UUID(), url: URL(string: "https://commondatastorage.googleapis.com/gtv-videos-bucket/sample/BigBuckBunny.mp4")!)],
    [Video(id: UUID(), url: URL(string: "https://commondatastorage.googleapis.com/gtv-videos-bucket/sample/BigBuckBunny.mp4")!)],
    [Video(id: UUID(), url: URL(string: "https://commondatastorage.googleapis.com/gtv-videos-bucket/sample/BigBuckBunny.mp4")!)],
    [Video(id: UUID(), url: URL(string: "https://commondatastorage.googleapis.com/gtv-videos-bucket/sample/BigBuckBunny.mp4")!)],
    [Video(id: UUID(), url: URL(string: "https://commondatastorage.googleapis.com/gtv-videos-bucket/sample/BigBuckBunny.mp4")!)],
    [Video(id: UUID(), url: URL(string: "https://commondatastorage.googleapis.com/gtv-videos-bucket/sample/BigBuckBunny.mp4")!)],
]

let videos: [Video] = [
    Video(id: UUID(), url: URL(string: "https://commondatastorage.googleapis.com/gtv-videos-bucket/sample/BigBuckBunny.mp4")!),
    Video(id: UUID(), url: URL(string: "https://commondatastorage.googleapis.com/gtv-videos-bucket/sample/BigBuckBunny.mp4")!),
    Video(id: UUID(), url: URL(string: "https://commondatastorage.googleapis.com/gtv-videos-bucket/sample/BigBuckBunny.mp4")!),
    Video(id: UUID(), url: URL(string: "https://commondatastorage.googleapis.com/gtv-videos-bucket/sample/BigBuckBunny.mp4")!),
    Video(id: UUID(), url: URL(string: "https://commondatastorage.googleapis.com/gtv-videos-bucket/sample/BigBuckBunny.mp4")!),
    Video(id: UUID(), url: URL(string: "https://commondatastorage.googleapis.com/gtv-videos-bucket/sample/BigBuckBunny.mp4")!),
    Video(id: UUID(), url: URL(string: "https://commondatastorage.googleapis.com/gtv-videos-bucket/sample/BigBuckBunny.mp4")!),
    Video(id: UUID(), url: URL(string: "https://commondatastorage.googleapis.com/gtv-videos-bucket/sample/BigBuckBunny.mp4")!),
    Video(id: UUID(), url: URL(string: "https://commondatastorage.googleapis.com/gtv-videos-bucket/sample/BigBuckBunny.mp4")!),
    Video(id: UUID(), url: URL(string: "https://commondatastorage.googleapis.com/gtv-videos-bucket/sample/BigBuckBunny.mp4")!),
    Video(id: UUID(), url: URL(string: "https://commondatastorage.googleapis.com/gtv-videos-bucket/sample/BigBuckBunny.mp4")!),
    Video(id: UUID(), url: URL(string: "https://commondatastorage.googleapis.com/gtv-videos-bucket/sample/BigBuckBunny.mp4")!),
    Video(id: UUID(), url: URL(string: "https://commondatastorage.googleapis.com/gtv-videos-bucket/sample/BigBuckBunny.mp4")!),
    Video(id: UUID(), url: URL(string: "https://commondatastorage.googleapis.com/gtv-videos-bucket/sample/BigBuckBunny.mp4")!),
    Video(id: UUID(), url: URL(string: "https://commondatastorage.googleapis.com/gtv-videos-bucket/sample/BigBuckBunny.mp4")!),
    Video(id: UUID(), url: URL(string: "https://commondatastorage.googleapis.com/gtv-videos-bucket/sample/BigBuckBunny.mp4")!),
    Video(id: UUID(), url: URL(string: "https://commondatastorage.googleapis.com/gtv-videos-bucket/sample/BigBuckBunny.mp4")!),
    Video(id: UUID(), url: URL(string: "https://commondatastorage.googleapis.com/gtv-videos-bucket/sample/BigBuckBunny.mp4")!),
    Video(id: UUID(), url: URL(string: "https://commondatastorage.googleapis.com/gtv-videos-bucket/sample/BigBuckBunny.mp4")!),
    Video(id: UUID(), url: URL(string: "https://commondatastorage.googleapis.com/gtv-videos-bucket/sample/BigBuckBunny.mp4")!),
    Video(id: UUID(), url: URL(string: "https://commondatastorage.googleapis.com/gtv-videos-bucket/sample/BigBuckBunny.mp4")!),
    Video(id: UUID(), url: URL(string: "https://commondatastorage.googleapis.com/gtv-videos-bucket/sample/BigBuckBunny.mp4")!),
    Video(id: UUID(), url: URL(string: "https://commondatastorage.googleapis.com/gtv-videos-bucket/sample/BigBuckBunny.mp4")!),
    Video(id: UUID(), url: URL(string: "https://commondatastorage.googleapis.com/gtv-videos-bucket/sample/BigBuckBunny.mp4")!),
    Video(id: UUID(), url: URL(string: "https://commondatastorage.googleapis.com/gtv-videos-bucket/sample/BigBuckBunny.mp4")!),
    Video(id: UUID(), url: URL(string: "https://commondatastorage.googleapis.com/gtv-videos-bucket/sample/BigBuckBunny.mp4")!),
    Video(id: UUID(), url: URL(string: "https://commondatastorage.googleapis.com/gtv-videos-bucket/sample/BigBuckBunny.mp4")!),
    Video(id: UUID(), url: URL(string: "https://commondatastorage.googleapis.com/gtv-videos-bucket/sample/BigBuckBunny.mp4")!),
    Video(id: UUID(), url: URL(string: "https://commondatastorage.googleapis.com/gtv-videos-bucket/sample/BigBuckBunny.mp4")!),
    Video(id: UUID(), url: URL(string: "https://commondatastorage.googleapis.com/gtv-videos-bucket/sample/BigBuckBunny.mp4")!),
    Video(id: UUID(), url: URL(string: "https://commondatastorage.googleapis.com/gtv-videos-bucket/sample/BigBuckBunny.mp4")!),
    Video(id: UUID(), url: URL(string: "https://commondatastorage.googleapis.com/gtv-videos-bucket/sample/BigBuckBunny.mp4")!),
    Video(id: UUID(), url: URL(string: "https://commondatastorage.googleapis.com/gtv-videos-bucket/sample/BigBuckBunny.mp4")!),
    Video(id: UUID(), url: URL(string: "https://commondatastorage.googleapis.com/gtv-videos-bucket/sample/BigBuckBunny.mp4")!),
    Video(id: UUID(), url: URL(string: "https://commondatastorage.googleapis.com/gtv-videos-bucket/sample/BigBuckBunny.mp4")!),
    Video(id: UUID(), url: URL(string: "https://commondatastorage.googleapis.com/gtv-videos-bucket/sample/BigBuckBunny.mp4")!),
    Video(id: UUID(), url: URL(string: "https://commondatastorage.googleapis.com/gtv-videos-bucket/sample/BigBuckBunny.mp4")!),
    Video(id: UUID(), url: URL(string: "https://commondatastorage.googleapis.com/gtv-videos-bucket/sample/BigBuckBunny.mp4")!),
    Video(id: UUID(), url: URL(string: "https://commondatastorage.googleapis.com/gtv-videos-bucket/sample/BigBuckBunny.mp4")!),
    Video(id: UUID(), url: URL(string: "https://commondatastorage.googleapis.com/gtv-videos-bucket/sample/BigBuckBunny.mp4")!),
    Video(id: UUID(), url: URL(string: "https://commondatastorage.googleapis.com/gtv-videos-bucket/sample/BigBuckBunny.mp4")!),
    Video(id: UUID(), url: URL(string: "https://commondatastorage.googleapis.com/gtv-videos-bucket/sample/BigBuckBunny.mp4")!),
    Video(id: UUID(), url: URL(string: "https://commondatastorage.googleapis.com/gtv-videos-bucket/sample/BigBuckBunny.mp4")!),
    Video(id: UUID(), url: URL(string: "https://commondatastorage.googleapis.com/gtv-videos-bucket/sample/BigBuckBunny.mp4")!),
    Video(id: UUID(), url: URL(string: "https://commondatastorage.googleapis.com/gtv-videos-bucket/sample/BigBuckBunny.mp4")!),
    Video(id: UUID(), url: URL(string: "https://commondatastorage.googleapis.com/gtv-videos-bucket/sample/BigBuckBunny.mp4")!),
    Video(id: UUID(), url: URL(string: "https://commondatastorage.googleapis.com/gtv-videos-bucket/sample/BigBuckBunny.mp4")!),
    Video(id: UUID(), url: URL(string: "https://commondatastorage.googleapis.com/gtv-videos-bucket/sample/BigBuckBunny.mp4")!),
]

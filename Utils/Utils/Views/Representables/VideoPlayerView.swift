//
//  VideoPlayerView.swift
//  Utils
//
//  Created by Jmy on 2023/10/30.
//
import AVKit
import SwiftUI

struct VideoPlayerView: View {
    var body: some View {
        VideoPlayerContainer(url: URL(string: "https://bitdash-a.akamaihd.net/content/sintel/hls/playlist.m3u8")!)
    }
}

struct VideoPlayerContainer: View {
    // The progress through the video, as a percentage (from 0 to 1)
    @State private var videoPos: Double = 0
    // The duration of the video in seconds
    @State private var videoDuration: Double = 0
    // Whether we're currently interacting with the seek bar or doing a seek
    @State private var seeking = false

    @State private var isPlaying = true
    @State private var currentTime: Float = 0.0
    @State private var playerPaused = true

    private let player: AVPlayer

    init(url: URL) {
        player = AVPlayer(url: url)
    }

    var body: some View {
        VStack {
            VideoPlayerRepresentable(isPlaying: $isPlaying, currentTime: $currentTime)
            Slider(value: $currentTime, in: 0 ... 1, step: 0.01, onEditingChanged: sliderEditingChanged)
            Button(action: {
                self.isPlaying.toggle()
            }) {
                Image(systemName: isPlaying ? "pause.fill" : "play.fill")
                    .font(.title)
            }
        }
    }

    private func pausePlayer(_ pause: Bool) {
        playerPaused = pause
        if playerPaused {
            player.pause()
        } else {
            player.play()
        }
    }

    private func sliderEditingChanged(editingStarted: Bool) {
        if editingStarted {
            // Set a flag stating that we're seeking so the slider doesn't
            // get updated by the periodic time observer on the player
            seeking = true
            pausePlayer(true)
        }

        // Do the seek if we're finished
        if !editingStarted {
            let targetTime = CMTime(seconds: videoPos * videoDuration,
                                    preferredTimescale: 600)
            player.seek(to: targetTime) { _ in
                // Now the seek is finished, resume normal operation
                self.seeking = false
                self.pausePlayer(false)
            }
        }
    }
}

struct VideoPlayerRepresentable: UIViewRepresentable {
    @Binding var isPlaying: Bool
    @Binding var currentTime: Float

    func makeUIView(context: Context) -> UIView {
        let playerView = VideoPlayerViewWrapper()
        playerView.isPlaying = isPlaying
        playerView.updateTime(currentTime)
        return playerView
    }

    func updateUIView(_ uiView: UIView, context: Context) {
        if let playerView = uiView as? VideoPlayerViewWrapper {
            playerView.isPlaying = isPlaying
            playerView.updateTime(currentTime)
        }
    }
}

class VideoPlayerViewWrapper: UIView {
    private var playerLayer: AVPlayerLayer?
    private var player: AVPlayer!
    private var playerItem: AVPlayerItem?

    var isPlaying: Bool = true {
        didSet {
            if isPlaying {
                player.play()
            } else {
                player.pause()
            }
        }
    }

    func updateTime(_ time: Float) {
        guard let playerItem = playerItem else { return }
        let seconds = CMTimeGetSeconds(playerItem.duration)
        let targetTime = CMTime(seconds: Double(time) * seconds, preferredTimescale: 600)
        player.seek(to: targetTime)
    }

    override init(frame: CGRect) {
        super.init(frame: frame)

        setupPlayer()
    }

    required init?(coder: NSCoder) {
        super.init(coder: coder)

        setupPlayer()
    }

    private func setupPlayer() {
        if playerLayer == nil, let url = URL(string: "https://bitdash-a.akamaihd.net/content/MI201109210084_1/m3u8s/f08e80da-bf1d-4e3d-8899-f0f6155f6efa.m3u8") {
            playerItem = AVPlayerItem(url: url)
            player = AVPlayer(playerItem: playerItem)
            playerLayer = AVPlayerLayer(player: player)
            playerLayer?.videoGravity = .resizeAspectFill
            layer.addSublayer(playerLayer!)
            player.play()
        }
    }

    override func layoutSubviews() {
        super.layoutSubviews()

        playerLayer?.frame = bounds
    }
}

#Preview {
    VideoPlayerView()
}

import AVKit
import SwiftUI

struct CustomVideoPlayerView: View {
    @State private var player = AVPlayer()
    @State private var subtitleOptions: [AVMediaSelectionOption] = []

    var body: some View {
        VStack {
            VideoPlayer(player: player)
                .onAppear {
                    setupPlayer()
                }

            // 자막 선택 버튼
            Menu("자막 변경") {
                ForEach(subtitleOptions, id: \.self) { option in
                    Button(action: {
                        selectSubtitle(option: option)
                    }) {
                        Text(option.displayName)
                    }
                }
                Button("자막 없음", action: {
                    selectSubtitle(option: nil)
                })
            }
        }
    }

    private func setupPlayer() {
        // 비디오 URL 설정
        guard let url = URL(string: "https://d3suxjer5uqf01.cloudfront.net/video/episode/interview/1/1.m3u8") else { return }
        let playerItem = AVPlayerItem(url: url)

        // 자막 트랙 가져오기
        if let group = playerItem.asset.mediaSelectionGroup(forMediaCharacteristic: .legible) {
            subtitleOptions = group.options
        }

        // 플레이어 설정
        player.replaceCurrentItem(with: playerItem)
        player.play()
    }

    private func selectSubtitle(option: AVMediaSelectionOption?) {
        guard let playerItem = player.currentItem,
              let group = playerItem.asset.mediaSelectionGroup(forMediaCharacteristic: .legible) else {
            return
        }

        // 선택한 자막을 플레이어에 적용
        playerItem.select(option, in: group)
    }
}

// #Preview {
//    CustomVideoPlayerView()
// }

struct DropDownMenu: View {
    var friuts = ["apple", "banana", "orange", "kiwi"]
    @State private var selectedFruit: String = "banana"

    var body: some View {
        VStack {
            Menu(content: {
                Picker("fruits", selection: $selectedFruit) {
                    ForEach(friuts, id: \.self) { fruit in
                        Text(fruit)
                    }
                }
            }, label: {
                Text("\(selectedFruit) ") + Text(Image(systemName: "chevron.up"))
            })
            .padding(.all, 16)
            .foregroundStyle(Color.white)
            .background(RoundedRectangle(cornerRadius: 16).fill(Color.black))
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .center)
        .background(Color(UIColor.lightGray).opacity(0.4))
    }
}

#Preview {
    DropDownMenu()
}

struct DropDownMenu2: View {
    @State private var sort: Int = 0

    var body: some View {
        NavigationView {
            Text("Hello World!")
                .toolbar {
                    ToolbarItem(placement: .primaryAction) {
                        Menu {
                            Picker(
                                selection: $sort,
                                label: Text("Sortingoptions")
                            ) {
                                Text("Sort1").tag(0)
                                Text("Sort2").tag(1)
                                Text("Sort3").tag(2)
                            }
                        }
                    label: {
                            Text("Sort")
                        }
                    }
                }
        }
    }
}

#Preview {
    DropDownMenu2()
}

@available(iOS 17.0, *)
struct DropDownMenu3: View {
    let options: [String]

    var menuWdith: CGFloat = 150
    var buttonHeight: CGFloat = 50
    var maxItemDisplayed: Int = 3

    @Binding var selectedOptionIndex: Int
    @Binding var showDropdown: Bool

    @State private var scrollPosition: Int?

    var body: some View {
        VStack {
            VStack(spacing: 0) {
                if showDropdown {
                    let scrollViewHeight: CGFloat = options.count > maxItemDisplayed ? (buttonHeight * CGFloat(maxItemDisplayed)) : (buttonHeight * CGFloat(options.count))
                    ScrollView {
                        LazyVStack(spacing: 0) {
                            ForEach(0 ..< options.count, id: \.self) { index in
                                Button(action: {
                                    withAnimation {
                                        selectedOptionIndex = index
                                        showDropdown.toggle()
                                    }

                                }, label: {
                                    HStack {
                                        Text(options[index])
                                        Spacer()
                                        if index == selectedOptionIndex {
                                            Image(systemName: "checkmark.circle.fill")
                                        }
                                    }

                                })
                                .padding(.horizontal, 20)
                                .frame(width: menuWdith, height: buttonHeight, alignment: .leading)
                            }
                        }
                        .scrollTargetLayout()
                    }
                    .scrollPosition(id: $scrollPosition)
                    .scrollDisabled(options.count <= 3)
                    .frame(height: scrollViewHeight)
                    .onAppear {
                        scrollPosition = selectedOptionIndex
                    }
                }
                // selected item
                Button(action: {
                    withAnimation {
                        showDropdown.toggle()
                    }
                }, label: {
                    HStack(spacing: nil) {
                        Text(options[selectedOptionIndex])
                        Spacer()
                        Image(systemName: "chevron.up")
                            .rotationEffect(.degrees(showDropdown ? -180 : 0))
                    }
                })
                .padding(.horizontal, 20)
                .frame(width: menuWdith, height: buttonHeight, alignment: .leading)
            }
            .foregroundStyle(Color.white)
            .background(RoundedRectangle(cornerRadius: 16).fill(Color.black))
        }
        .frame(width: menuWdith, height: buttonHeight, alignment: .bottom)
        .zIndex(100)
    }
}

@available(iOS 17.0, *)
struct DropDownMenuDemo: View {
    let fruits = ["apple", "banana", "orange", "kiwi"]
    @State private var selectedOptionIndex = 0
    @State private var showDropdown = false

    var body: some View {
        VStack {
            DropDownMenu3(options: fruits, selectedOptionIndex: $selectedOptionIndex, showDropdown: $showDropdown)
            Spacer()
                .frame(height: 30)
            Text("You have selected \(fruits[selectedOptionIndex])")
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .center)
        .background(Color.yellow)
        .onTapGesture {
            withAnimation {
                showDropdown = false
            }
        }
    }
}

#Preview {
    if #available(iOS 17.0, *) {
        DropDownMenuDemo()
    } else {
        // Fallback on earlier versions
    }
}

struct SliderView: View {
    @State private var speed = 50.0

    var minValue: Double = 1
    var maxValue: Double = 100

    var body: some View {
        HStack {
            Text("\(minValue, specifier: "%.f")")
            Slider(value: $speed, in: minValue ... maxValue, step: 1)
                .alignmentGuide(VerticalAlignment.center) { $0[VerticalAlignment.center] }
                .padding(.top)
                .overlay(GeometryReader { gp in
                    Text("\(speed, specifier: "%.f")").foregroundColor(.blue)
                        .alignmentGuide(HorizontalAlignment.leading) {
                            $0[HorizontalAlignment.leading] - (gp.size.width - $0.width) * speed / (maxValue - minValue)
                        }
                        .frame(maxWidth: .infinity, alignment: .leading)
                }, alignment: .top)
            Text("\(maxValue, specifier: "%.f")")
        }
        .padding()
    }
}

#Preview {
    SliderView()
}

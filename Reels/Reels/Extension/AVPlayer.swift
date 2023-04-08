//
//  AVPlayer.swift
//  Reels
//
//  Created by Jmy on 2023/04/08.
//

import AVKit

extension AVPlayer {
    convenience init(url URL: URL) {
        let playerItem = AVPlayerItem(url: URL)
        playerItem.preferredForwardBufferDuration = 1
        
        self.init(playerItem: playerItem)
    }
    
    func replaceURL(_ URL: URL) {
        let asset = AVAsset(url: URL)
        let playerItem = AVPlayerItem(asset: asset)
        playerItem.preferredForwardBufferDuration = 1
        
        replaceCurrentItem(with: playerItem)
    }
    
    var isPlaying: Bool {
        /// rate: 0 - 일시 정지
        /// rate: 1 - 일반 속도 재생
        return rate != 0 && error == nil
    }
}

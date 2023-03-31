//
//  AVPlayerItem.swift
//  Reels
//
//  Created by Jmy on 2023/03/31.
//

import AVFoundation.AVPlayerItem

extension AVPlayerItem {
    var url: URL? {
        return (asset as? AVURLAsset)?.url
    }
}

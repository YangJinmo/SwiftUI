//
//  Reel.swift
//  Reels
//
//  Created by Jmy on 2023/03/08.
//

import SwiftUI
import AVKit

struct Reel: Identifiable {
    var id = UUID().uuidString
    var player: AVPlayer?
    var mediaFile: MediaFile
}

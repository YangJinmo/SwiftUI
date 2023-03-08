//
//  MediaFile.swift
//  Reels
//
//  Created by Jmy on 2023/03/08.
//

import SwiftUI

struct MediaFile: Identifiable {
    var id = UUID().uuidString
    var url: String
    var title: String
    var isExpanded: Bool = false
}

var mediaFiles = [
    MediaFile(url: "Reels1", title: "Apple AirTag...."),
    MediaFile(url: "Reels2", title: "omg...... Animal crossing"),
    MediaFile(url: "Reels3", title: "So hyped for Halo...."),
    MediaFile(url: "Reels4", title: "SponsorShip....."),
    MediaFile(url: "Reels5", title: "I've been creating more vertical 30 second content"),
    MediaFile(url: "Reels6", title: "The brand new Apple Tower Theater opens"),
]

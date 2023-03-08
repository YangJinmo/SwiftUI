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
    MediaFile(url: "https://d3po4q2cli99m3.cloudfront.net/review/video/180/20220512_mixed_bugaboo_bee6_wheel_break_handling.m3u8", title: "Apple AirTag...."),
    MediaFile(url: "https://d3po4q2cli99m3.cloudfront.net/review/video/179/20220512_mixed_bugaboo_bee6_seatback_sunscreen.m3u8", title: "omg...... Animal crossing"),
    MediaFile(url: "https://d3po4q2cli99m3.cloudfront.net/review/video/132/6dc2dec4-67a7-4268-98c7-b8e1a2886426.m3u8", title: "So hyped for Halo...."),
    MediaFile(url: "https://d3po4q2cli99m3.cloudfront.net/review/video/1/d16adaa0-0699-4219-9cbb-ba530c383a85.m3u8", title: "SponsorShip....."),
    MediaFile(url: "https://d3po4q2cli99m3.cloudfront.net/review/video/180/20220512_mixed_bugaboo_bee6_wheel_break_handling.m3u8", title: "I've been creating more vertical 30 second content"),
    MediaFile(url: "https://d3po4q2cli99m3.cloudfront.net/review/video/179/20220512_mixed_bugaboo_bee6_seatback_sunscreen.m3u8", title: "The brand new Apple Tower Theater opens"),
]

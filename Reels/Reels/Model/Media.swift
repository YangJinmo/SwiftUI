//
//  Media.swift
//  Reels
//
//  Created by Jmy on 2023/03/08.
//

import SwiftUI

struct Media: Identifiable {
    var id = UUID().uuidString
    var url: String
    var title: String
    var isExpanded: Bool = false
}

var medias = [
    Media(url: "https://bitdash-a.akamaihd.net/content/MI201109210084_1/m3u8s/f08e80da-bf1d-4e3d-8899-f0f6155f6efa.m3u8", title: "Revenge🔥🔥💥💥💥"),
    Media(url: "https://assets.afcdn.com/video49/20210722/v_645516.m3u8", title: "Revenge🔥🔥💥💥💥"),
    Media(url: "http://sample.vodobox.net/skate_phantom_flex_4k/skate_phantom_flex_4k.m3u8", title: "Revenge🔥🔥💥💥💥"),
    Media(url: "http://content.jwplatform.com/manifests/vM7nH0Kl.m3u8", title: "Revenge🔥🔥💥💥💥"),
    Media(url: "http://qthttp.apple.com.edgesuite.net/1010qwoeiuryfg/sl.m3u8", title: "Revenge🔥🔥💥💥💥"),

    Media(url: "https://d3po4q2cli99m3.cloudfront.net/review/video/180/20220512_mixed_bugaboo_bee6_wheel_break_handling.m3u8", title: "Revenge🔥🔥💥💥💥"),
    Media(url: "https://d3po4q2cli99m3.cloudfront.net/review/video/179/20220512_mixed_bugaboo_bee6_seatback_sunscreen.m3u8", title: "Revenge🔥🔥💥💥💥"),
    Media(url: "https://d3po4q2cli99m3.cloudfront.net/review/video/132/6dc2dec4-67a7-4268-98c7-b8e1a2886426.m3u8", title: "Revenge🔥🔥💥💥💥"),
    Media(url: "https://d3po4q2cli99m3.cloudfront.net/review/video/1/d16adaa0-0699-4219-9cbb-ba530c383a85.m3u8", title: "Revenge🔥🔥💥💥💥"),
    Media(url: "https://d3po4q2cli99m3.cloudfront.net/review/video/180/20220512_mixed_bugaboo_bee6_wheel_break_handling.m3u8", title: "Revenge🔥🔥💥💥💥"),
    Media(url: "https://d3po4q2cli99m3.cloudfront.net/review/video/179/20220512_mixed_bugaboo_bee6_seatback_sunscreen.m3u8", title: "Revenge🔥🔥💥💥💥"),
]

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
]

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

//
//  NewsListItem.swift
//  InifiniteList
//
//  Created by Jmy on 2023/04/26.
//

import SwiftUI

class NewsListItem: Identifiable, Codable {
    var uuid = UUID()

    var author: String?
    var title: String
    var url: String

    enum CodingKeys: String, CodingKey {
        case author, title, url
    }
}

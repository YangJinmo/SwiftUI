//
//  NewsApiResponse.swift
//  InifiniteList
//
//  Created by Jmy on 2023/04/26.
//

class NewsApiResponse: Codable {
    var status: String
    var articles: [NewsListItem]?
}

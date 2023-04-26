//
//  NewsListItemListView.swift
//  InifiniteList
//
//  Created by Jmy on 2023/04/26.
//

import SwiftUI

struct NewsListItemListView: View {
    var article: NewsListItem

    var body: some View {
        HStack {
            VStack(alignment: .leading) {
                Text("\(article.title)")
                    .font(.headline)
                Text("\(article.author ?? "No Author")")
                    .font(.subheadline)
            }
        }
    }
}

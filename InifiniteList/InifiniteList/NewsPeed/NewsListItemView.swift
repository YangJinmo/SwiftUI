//
//  NewsListItemView.swift
//  InifiniteList
//
//  Created by Jmy on 2023/04/26.
//

import SwiftUI

struct NewsListItemView: View {
    var article: NewsListItem

    var body: some View {
        VStack {
            UrlWebView(urlToDisplay: URL(string: article.url)!)
                .edgesIgnoringSafeArea(.all)
                .navigationBarTitle(article.title)
        }
    }
}

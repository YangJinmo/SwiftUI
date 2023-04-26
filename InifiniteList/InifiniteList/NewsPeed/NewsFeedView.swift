//
//  NewsFeedView.swift
//  InifiniteList
//
//  Created by Jmy on 2023/04/26.
//

import SwiftUI

struct NewsFeedView: View {
    @ObservedObject var newsFeed = NewsFeed()

    var body: some View {
        NavigationView {
            List(newsFeed) { (article: NewsListItem) in
                NavigationLink(destination: NewsListItemView(article: article)) {
                    NewsListItemListView(article: article)
                        .onAppear {
                            self.newsFeed.loadMoreArticles(currentItem: article)
                        }
                }
            }
            .navigationBarTitle("Apple News")
        }
    }
}

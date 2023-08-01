//
//  Refreshable.swift
//  Utils
//
//  Created by Jmy on 2023/07/25.
//

import SwiftUI

struct NewsItem: Decodable, Identifiable {
    let id: Int
    let title: String
    let strap: String
}

struct Refreshable: View {
    @State private var news = [
        NewsItem(id: 0, title: "Want the latest news?", strap: "Pull to refresh!"),
    ]

    var body: some View {
        List(news) { item in
            VStack(alignment: .leading) {
                Text(item.title)
                    .font(.headline)
                Text(item.strap)
                    .foregroundStyle(.secondary)
            }
        }
        .refreshable {
            do {
                // Fetch and decode JSON into news items
                let url = URL(string: "https://www.hackingwithswift.com/samples/news-1.json")!
                let (data, _) = try await URLSession.shared.data(from: url)
                news = try JSONDecoder().decode([NewsItem].self, from: data)
            } catch {
                // Something went wrong; clear the news
                news = []
            }
        }
    }
}

struct Refreshable_Previews: PreviewProvider {
    static var previews: some View {
        Refreshable()
    }
}

struct PullToRefresh: View {
    var coordinateSpaceName: String
    var onRefresh: () -> Void

    @State var needRefresh: Bool = false

    var body: some View {
        GeometryReader { geo in
            if geo.frame(in: .named(coordinateSpaceName)).midY > 50 {
                Spacer()
                    .onAppear {
                        needRefresh = true
                    }

            } else if geo.frame(in: .named(coordinateSpaceName)).maxY < 10 {
                Spacer()
                    .onAppear {
                        if needRefresh {
                            needRefresh = false
                            onRefresh()
                        }
                    }
            }

            HStack {
                Spacer()

                if needRefresh {
                    ProgressView()
                } else {
                    Text("⬇️")
                }

                Spacer()
            }
        }
        .padding(.top, -50)
    }
}

struct PullToRefresh_Previews: PreviewProvider {
    static var previews: some View {
        NewsItemView()
    }
}

struct NewsItemView: View {
    @State private var news = [
        NewsItem(id: 0, title: "Want the latest news?", strap: "Pull to refresh!"),
    ]

    var body: some View {
        ScrollView {
            PullToRefresh(coordinateSpaceName: "pullToRefresh") {
                // do your stuff when pulled
                print("pullToRefresh")
                
                news = [
                    NewsItem(id: 0, title: "Want the latest news?", strap: "Pull to refresh!"),
                    NewsItem(id: 1, title: "Want the latest news?", strap: "Pull to refresh!"),
                    NewsItem(id: 2, title: "Want the latest news?", strap: "Pull to refresh!"),
                ]
            }
            
            LazyVStack(spacing: 0) {
                ForEach(news) { item in
                    VStack(alignment: .leading) {
                        Text(item.title)
                            .font(.headline)
                        Text(item.strap)
                            .foregroundStyle(.secondary)
                    }
                }
            }
        }
        .coordinateSpace(name: "pullToRefresh")
    }
}

import SwiftUI

struct PullToRefreshView: View {
    private static let minRefreshTimeInterval = TimeInterval(0.2)
    private static let triggerHeight = CGFloat(100)
    private static let indicatorHeight = CGFloat(100)
    private static let fullHeight = triggerHeight + indicatorHeight

    let backgroundColor: Color
    let foregroundColor: Color
    let isEnabled: Bool
    let onRefresh: () -> Void

    @State private var isRefreshIndicatorVisible = false
    @State private var refreshStartTime: Date? = nil

    init(bg: Color = .white, fg: Color = .black, isEnabled: Bool = true, onRefresh: @escaping () -> Void) {
        backgroundColor = bg
        foregroundColor = fg
        self.isEnabled = isEnabled
        self.onRefresh = onRefresh
    }

    var body: some View {
        VStack(spacing: 0) {
            LazyVStack(spacing: 0) {
                Color.clear
                    .frame(height: Self.triggerHeight)
                    .onAppear {
                        if isEnabled {
                            withAnimation {
                                isRefreshIndicatorVisible = true
                            }
                            refreshStartTime = Date()
                        }
                    }
                    .onDisappear {
                        if isEnabled, isRefreshIndicatorVisible, let diff = refreshStartTime?.distance(to: Date()), diff > Self.minRefreshTimeInterval {
                            onRefresh()
                        }
                        withAnimation {
                            isRefreshIndicatorVisible = false
                        }
                        refreshStartTime = nil
                    }
            }
            .frame(height: Self.triggerHeight)

            indicator
                .frame(height: Self.indicatorHeight)
        }
        .background(backgroundColor)
        .ignoresSafeArea(edges: .all)
        .frame(height: Self.fullHeight)
        .padding(.top, -Self.fullHeight)
    }

    private var indicator: some View {
        ProgressView()
            .progressViewStyle(CircularProgressViewStyle(tint: foregroundColor))
            .opacity(isRefreshIndicatorVisible ? 1 : 0)
    }
}

struct PullToRefreshView_Previews: PreviewProvider {
    static var previews: some View {
        PullToRefreshViewView()
    }
}

struct PullToRefreshViewView: View {
    @State private var news = [
        NewsItem(id: 0, title: "Want the latest news?", strap: "Pull to refresh!"),
    ]

    var body: some View {
        ScrollView {
            VStack(spacing: 0) {
                PullToRefreshView {
                    print("refreshing")
                    
                    news = [
                        NewsItem(id: 0, title: "Want the latest news?", strap: "Pull to refresh!"),
                        NewsItem(id: 1, title: "Want the latest news?", strap: "Pull to refresh!"),
                        NewsItem(id: 2, title: "Want the latest news?", strap: "Pull to refresh!"),
                    ]
                }

                LazyVStack(spacing: 0) {
                    ForEach(news) { item in
                        VStack(alignment: .leading) {
                            Text(item.title)
                                .font(.headline)
                            Text(item.strap)
                                .foregroundStyle(.secondary)
                        }
                    }
                }
            }
        }
    }
}

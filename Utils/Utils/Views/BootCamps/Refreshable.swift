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

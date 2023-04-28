//
//  InfiniteListWithPullToRefresh.swift
//  InifiniteList
//
//  Created by Jmy on 2023/04/27.
//

import Combine
import SwiftUI
import SwiftUIPullToRefresh

public struct InfiniteListWithPullToRefresh<Data, Content, LoadingView>: View
    where Data: RandomAccessCollection, Data.Element: Hashable, Content: View, LoadingView: View {
    @Binding var data: Data
    @Binding var isLoading: Bool
    let loadingView: LoadingView
    let loadMore: () -> Void
    let onRefresh: OnRefresh?
    let content: (Data.Element) -> Content

    public init(data: Binding<Data>,
                isLoading: Binding<Bool>,
                loadingView: LoadingView,
                loadMore: @escaping () -> Void,
                onRefresh: OnRefresh? = nil,
                @ViewBuilder content: @escaping (Data.Element) -> Content) {
        _data = data
        _isLoading = isLoading
        self.loadingView = loadingView
        self.loadMore = loadMore
        self.onRefresh = onRefresh
        self.content = content
    }

    public var body: some View {
        if onRefresh != nil {
            RefreshableScrollView(onRefresh: onRefresh!) {
                scrollableContent
                    .onAppear(perform: loadMore)
            }
        } else {
            List {
                listItems
            }.onAppear(perform: loadMore)
        }
    }

    private var scrollableContent: some View {
        Group {
            if #available(iOS 14.0, *) {
                LazyVStack(spacing: 10) {
                    listItems
                }
            } else {
                VStack(spacing: 10) {
                    listItems
                }
            }
        }
    }

    private var listItems: some View {
        Group {
            ForEach(data, id: \.self) { item in
                content(item)
                    .onAppear {
                        if item == data.last {
                            loadMore()
                        }
                    }
            }
            if isLoading {
                loadingView
                    .frame(idealWidth: .infinity, maxWidth: .infinity, alignment: .center)
            }
        }
    }
}

private class ListViewModel: ObservableObject {
    @Published var items = [ListItem]()
    @Published var isLoading = false
    private var page = 1
    private var subscriptions = Set<AnyCancellable>()

    func loadMore() {
        guard !isLoading else { return }

        isLoading = true
        (1 ... 15).publisher
            .map { index in ListItem(text: "Page: \(page) item: \(index)") }
            .collect()
            .delay(for: .seconds(2), scheduler: RunLoop.main)
            .sink { [self] _ in
                isLoading = false
                page += 1
            } receiveValue: { [self] value in
                items += value
            }
            .store(in: &subscriptions)
    }

    func refresh(refreshComplete: RefreshComplete) {
        subscriptions.forEach { $0.cancel() }
        items.removeAll()
        isLoading = false
        page = 1
        loadMore()
        refreshComplete()
    }
}

struct InfiniteListWithPullToRefreshTest: View {
    @ObservedObject fileprivate var viewModel: ListViewModel

    var body: some View {
        InfiniteListWithPullToRefresh(
            data: $viewModel.items,
            isLoading: $viewModel.isLoading,
            loadingView: ProgressView(),
            loadMore: viewModel.loadMore,
            onRefresh: viewModel.refresh(refreshComplete:)
        ) { item in
            Text(item.text)
        }
    }
}

struct InfiniteListWithPullToRefresh_Previews: PreviewProvider {
    static var previews: some View {
        InfiniteListWithPullToRefreshTest(viewModel: ListViewModel())
    }
}

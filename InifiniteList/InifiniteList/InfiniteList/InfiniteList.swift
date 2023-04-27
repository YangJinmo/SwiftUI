//
//  InfiniteList.swift
//  InifiniteList
//
//  Created by Jmy on 2023/04/27.
//

import Combine
import SwiftUI

struct InfiniteList<Data, Content>: View
    where Data: RandomAccessCollection, Data.Element: Hashable, Content: View {
    @Binding var data: Data // 1
    @Binding var isLoading: Bool // 2
    let loadMore: () -> Void // 3
    let content: (Data.Element) -> Content // 4

    init(data: Binding<Data>,
         isLoading: Binding<Bool>,
         loadMore: @escaping () -> Void,
         @ViewBuilder content: @escaping (Data.Element) -> Content) { // 5
        _data = data
        _isLoading = isLoading
        self.loadMore = loadMore
        self.content = content
    }

    var body: some View {
        List {
            ForEach(data, id: \.self) { item in
                content(item)
                    .onAppear {
                        if item == data.last { // 6
                            loadMore()
                        }
                    }
            }
            if isLoading { // 7
                ProgressView()
                    .frame(idealWidth: .infinity, maxWidth: .infinity, alignment: .center)
            }
        }.onAppear(perform: loadMore) // 8
    }
}

struct ListItem: Hashable {
    let text: String
}

class ListViewModel: ObservableObject {
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
}

struct InifiniteListTest: View {
    @ObservedObject var viewModel: ListViewModel

    var body: some View {
        InfiniteList(data: $viewModel.items,
                     isLoading: $viewModel.isLoading,
                     loadMore: viewModel.loadMore) { item in
            Text(item.text)
        }
    }
}

struct InfiniteListTest_Previews: PreviewProvider {
    static var previews: some View {
        InifiniteListTest(viewModel: ListViewModel())
    }
}

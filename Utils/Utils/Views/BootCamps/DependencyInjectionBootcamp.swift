//
//  DependencyInjectionBootcamp.swift
//  Utils
//
//  Created by Jmy on 4/4/24.
//

import Combine
import SwiftUI

// PROBLEMS WITH SINGLETONS
// 1. Singleton's are GLOBAL
// 2. Can't customize the init!
// 3. Can't swap out dependencies
// https://youtu.be/E3x07blYvdE?si=dhZJ84N4zFkO1aMF&t=930

// 1. Singleton's are GLOBAL
// ProductionDataService.instance.getData()

struct PostsModel: Identifiable, Codable {
    let userId: Int
    let id: Int
    let title: String
    let body: String
}

protocol DataServiceProtocol {
    func getData() -> AnyPublisher<[PostsModel], Error>
}

class ProductionDataService: DataServiceProtocol {
    // static let instance = ProductionDataService() // Singleton

    // 2. Can't customize the init!
    // static let instance = ProductionDataService(title: "now")
    // init(title: String) { }

    // let url: URL = URL(string: "https://jsonplaceholder.typicode.com/posts")!

    let url: URL

    init(url: URL) {
        self.url = url
    }

    func getData() -> AnyPublisher<[PostsModel], Error> {
        URLSession.shared.dataTaskPublisher(for: url)
            .map({ $0.data })
            .decode(type: [PostsModel].self, decoder: JSONDecoder())
            .receive(on: DispatchQueue.main)
            .eraseToAnyPublisher()
    }
}

class MockDataService: DataServiceProtocol {
    let testData: [PostsModel]

    init(data: [PostsModel]?) {
        testData = data ?? [
            PostsModel(userId: 1, id: 1, title: "One", body: "one"),
            PostsModel(userId: 2, id: 2, title: "Two", body: "two"),
        ]
    }

    func getData() -> AnyPublisher<[PostsModel], Error> {
        Just(testData)
            .tryMap { $0 }
            .eraseToAnyPublisher()
    }
}

// class Dependencies {
//    let dataService: DataServiceProtocol
//
//    init(dataService: DataServiceProtocol) {
//        self.dataService = dataService
//    }
// }

class DependencyInjectionViewModel: ObservableObject {
    @Published var dataArray: [PostsModel] = []
    var cancellables = Set<AnyCancellable>()
    let dataService: DataServiceProtocol

    init(dataService: DataServiceProtocol) {
        self.dataService = dataService
        loadPosts()
    }

    private func loadPosts() {
        // ProductionDataService.instance.getData()
        dataService.getData()
            .sink { _ in

            } receiveValue: { [weak self] returnedPosts in
                self?.dataArray = returnedPosts
            }
            .store(in: &cancellables)
    }
}

struct DependencyInjectionBootcamp: View {
    // @StateObject private var vm = DependencyInjectionViewModel()
    @StateObject private var vm: DependencyInjectionViewModel

    init(dataService: DataServiceProtocol) {
        _vm = StateObject(wrappedValue: DependencyInjectionViewModel(dataService: dataService))
    }

//    init(dataService: Dependencies) {
//        _vm = StateObject(wrappedValue: DependencyInjectionViewModel(dataService: dataService))
//    }

    var body: some View {
        ScrollView {
            VStack {
                ForEach(vm.dataArray) { post in
                    Text(post.title)
                }
            }
        }
    }
}

#Preview {
    // DependencyInjectionBootcamp(dataService: ProductionDataService(url: URL(string: "https://jsonplaceholder.typicode.com/posts")!))

    DependencyInjectionBootcamp(dataService: MockDataService(data: [
        PostsModel(userId: 1234, id: 1234, title: "test", body: "test"),
    ]))
}

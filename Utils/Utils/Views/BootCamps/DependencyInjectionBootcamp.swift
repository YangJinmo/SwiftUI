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
// 3. Can't swap out service - https://youtu.be/E3x07blYvdE?si=dhZJ84N4zFkO1aMF&t=930

// 1. Singleton's are GLOBAL
// ProductionDataService.instance.getData()

struct PostsModel: Identifiable, Codable {
    let userId: Int
    let id: Int
    let title: String
    let body: String
}

class ProductionDataService {
    static let instance = ProductionDataService() // Singleton

    // 2. Can't customize the init!
    // static let instance = ProductionDataService(title: "now")
    // init(title: String) { }

    let url: URL = URL(string: "https://jsonplaceholder.typicode.com/posts")!

    func getData() -> AnyPublisher<[PostsModel], Error> {
        URLSession.shared.dataTaskPublisher(for: url)
            .map({ $0.data })
            .decode(type: [PostsModel].self, decoder: JSONDecoder())
            .receive(on: DispatchQueue.main)
            .eraseToAnyPublisher()
    }
}

class DependencyInjectionViewModel: ObservableObject {
    @Published var dataArray: [PostsModel] = []
    var cancellables = Set<AnyCancellable>()

    init() {
        loadPosts()
    }

    private func loadPosts() {
        ProductionDataService.instance.getData()
            .sink { _ in

            } receiveValue: { [weak self] returnedPosts in
                self?.dataArray = returnedPosts
            }
            .store(in: &cancellables)
    }
}

struct DependencyInjectionBootcamp: View {
    @StateObject private var vm = DependencyInjectionViewModel()

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
    DependencyInjectionBootcamp()
}

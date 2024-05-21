//
//  AdvancedCombineBootcamp.swift
//  Utils
//
//  Created by Jmy on 5/22/24.
//

import Combine
import SwiftUI

class AdvancedCombineDataService {
    // @Published var basicPublisher: String = "first publish"
    let currentValuePublisher = CurrentValueSubject<String, Never>("first publish")

    init() {
        publishFakeData()
    }

    private func publishFakeData() {
        let items = ["one", "two", "three"]

        for x in items.indices {
            DispatchQueue.main.asyncAfter(deadline: .now() + Double(x)) {
                // self.basicPublisher = items[x]
                self.currentValuePublisher.send(items[x])
            }
        }
    }
}

class AdvancedCombineBootcampViewModel: ObservableObject {
    @Published var data: [String] = []
    let dataService = AdvancedCombineDataService()

    var cancellables = Set<AnyCancellable>()

    init() {
        addSubscribers()
    }

    private func addSubscribers() {
        dataService.currentValuePublisher // $basicPublisher
            .sink { completion in
                switch completion {
                case .finished:
                    break
                case let .failure(error):
                    print("ERROR: \(error.localizedDescription)")
                }
            } receiveValue: { [weak self] returnedValue in
                self?.data.append(returnedValue)
            }
            .store(in: &cancellables)
    }
}

struct AdvancedCombineBootcamp: View {
    @StateObject private var vm = AdvancedCombineBootcampViewModel()

    var body: some View {
        ScrollView {
            VStack {
                ForEach(vm.data, id: \.self) {
                    Text($0)
                        .font(.largeTitle)
                        .fontWeight(.black)
                }
            }
        }
    }
}

#Preview {
    AdvancedCombineBootcamp()
}

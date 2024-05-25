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
    // let currentValuePublisher = CurrentValueSubject<String, Never>("first publish")
    // let currentValuePublisher = CurrentValueSubject<Int, Error>("first publish")
    let passThroughPublisher = PassthroughSubject<Int, Error>()

    init() {
        publishFakeData()
    }

    private func publishFakeData() {
        let items: [Int] = Array(0 ..< 11)

        for x in items.indices {
            DispatchQueue.main.asyncAfter(deadline: .now() + Double(x)) {
                // self.basicPublisher = items[x]
                // self.currentValuePublisher.send(items[x])
                self.passThroughPublisher.send(items[x])
                
                if x == items.indices.last {
                    self.passThroughPublisher.send(completion: .finished)
                }
            }
        }
    }
}

class AdvancedCombineBootcampViewModel: ObservableObject {
    @Published var data: [String] = []
    @Published var error: String = ""
    let dataService = AdvancedCombineDataService()

    var cancellables = Set<AnyCancellable>()

    init() {
        addSubscribers()
    }

    private func addSubscribers() {
        dataService.passThroughPublisher // currentValuePublisher // $basicPublisher

            // Sequence Operations
            // .first()
            // .first(where: { int in
            //    return int > 4
            // })
            // .first(where: { $0 > 4 })
            // .tryFirst(where: { int in
            //    if int == 3 {
            //      throw URLError(.badServerResponse)
            //    }
            //    return int > 4
            // })
            // .last()
            // .last(where: { $0 < 4 })
            // .tryLast(where: { int in
            //     if int == 13 {
            //         throw URLError(.badServerResponse)
            //     }
            //     return int > 1
            // })
            // .dropFirst()
            // .dropFirst(3)
            // .drop(while: { $0 > 5 })
            // .tryDrop(while: { int in
            //     if int == 15 {
            //         throw URLError(.badServerResponse)
            //     }
            //     return int < 6
            // })
        

            .map({ String($0) })
            .sink { completion in
                switch completion {
                case .finished:
                    break
                case let .failure(error):
                    self.error = "ERROR: \(error)"
                    self.error = "ERROR: \(error.localizedDescription)"
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

                if !vm.error.isEmpty {
                    Text(vm.error)
                }
            }
        }
    }
}

#Preview {
    AdvancedCombineBootcamp()
}

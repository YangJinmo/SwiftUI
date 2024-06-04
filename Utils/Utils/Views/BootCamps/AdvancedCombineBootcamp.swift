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
        let items: [Int] = [1, 2, 3, 4, 5, 6, 7, 8, 9, 10] // Array(1 ..< 11)

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

//        DispatchQueue.main.asyncAfter(deadline: .now() + 0) {
//            self.passThroughPublisher.send(1)
//        }
//
//        DispatchQueue.main.asyncAfter(deadline: .now() + 0.5) {
//            self.passThroughPublisher.send(2)
//        }
//
//        DispatchQueue.main.asyncAfter(deadline: .now() + 1.5) {
//            self.passThroughPublisher.send(3)
//        }
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
            /*
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
             // .prefix(4)
             // .prefix(while: { $0 < 5 })
             // .tryPrefix(while: )
             // .output(at: 5)
             // .output(in: 2 ..< 4)
             */

            // Mathematic Operations
            /*
             // .max()
             // .max(by: { int1, int2 in
             //     return int1 < int2
             // })
             // .tryMax(by: )
             // .min()
             // .min(by: )
             // .tryMin(by: )
             */

            // Filter / Reducing Operations
            /*
             // .map({ String($0) })
             // .tryMap({ int in
             //     if int == 5 {
             //         throw URLError(.badServerResponse)
             //     }
             //     return String(int)
             // })
             // .compactMap({ int in
             //     if int == 5 {
             //         return nil
             //     }
             //     return "\(int)"// String(int)
             // })
             // .tryCompactMap()
             // .filter({ ($0 > 3) && ($0 < 7) })
             // .tryFilter()
             // .removeDuplicates() // let items: [Int] = [1,2,3,4,4,5,4,6,7,8,9,10]
             // .removeDuplicates(by: { int1, int2 in
             //     return int1 == int2
             // })
             // .tryRemoveDuplicates(by: )
             // .replaceNil(with: 5)
             // .replaceEmpty(with: [])
             // .replaceError(with: "DEFAULT ERROR")
             // .scan(0, { existingValue, newValue in
             //     return existingValue + newValue
             // })
             // .scan(0, { $0 + $1 })
             // .scan(0, +)
             // .tryScan(0, )
             // .reduce(0, { existingValue, newValue in
             //     return existingValue + newValue
             // })
             // .reduce(0, +)
             // .tryReduce(0, )

             // .map({ String($0) })
             // .collect() // self?.data = returnedValue
             // .collect(3) // self?.data.append(contentsOf: returnedValue)
             // .allSatisfy({ $0 == 5 })
             // .allSatisfy({ $0 < 50 })
             // .tryAllSatisfy()
             */

            // Timing Operations
            /*
             // .debounce(for: 0.75, scheduler: DispatchQueue.main)
             // .delay(for: 2, scheduler: DispatchQueue.main)
             // .measureInterval(using: DispatchQueue.main)
             // .map({ stride in
             //     return "\(stride.timeInterval)"
             // })
             // .throttle(for: 2, scheduler: DispatchQueue.main, latest: true) // 1, 3, 5, 7, 9, 10
             // .throttle(for: 10, scheduler: DispatchQueue.main, latest: true) // 1, 10
             // .throttle(for: 10, scheduler: DispatchQueue.main, latest: false) // 1, 2
             // .throttle(for: 5, scheduler: DispatchQueue.main, latest: true) // 1, 6, 10
             // .retry(3)
             // .timeout(0.75, scheduler: DispatchQueue.main)
             */

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
                // self?.data = returnedValue
                // self?.data.append(contentsOf: returnedValue)
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

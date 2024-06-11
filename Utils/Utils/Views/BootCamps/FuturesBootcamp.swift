//
//  FuturesBootcamp.swift
//  Utils
//
//  Created by Jmy on 6/12/24.
//

import Combine
import SwiftUI

// download with Combine
// download with @escaping closure
// convert @escaping closure to Combine

class FuturesBootcampViewModel: ObservableObject {
    @Published var title: String = "Starting title"
    let url = URL(string: "https://www.google.com")!
    var cancellables = Set<AnyCancellable>()

    init() {
        download()
    }

    func download() {
//        getCombinePublisher()
//            .sink { _ in
//
//            } receiveValue: { [weak self] returnedValue in
//                self?.title = returnedValue
//            }
//            .store(in: &cancellables)

//        getEscapingClosure { [weak self] returnedValue, error in
//            self?.title = returnedValue
//        }

        getFuturePublisher()
            .sink { _ in

            } receiveValue: { [weak self] returnedValue in
                self?.title = returnedValue
            }
            .store(in: &cancellables)
    }

    func getCombinePublisher() -> AnyPublisher<String, URLError> {
        URLSession.shared.dataTaskPublisher(for: url)
            .timeout(1, scheduler: DispatchQueue.main)
            .map({ _ in
                "New value"
            })
            .eraseToAnyPublisher()
    }

    func getEscapingClosure(completionHandler: @escaping (_ value: String, _ error: Error?) -> Void) {
        URLSession.shared.dataTask(with: url) { _, _, _ in
            completionHandler("New value 2", nil)
        }
        .resume()
    }

    func getFuturePublisher() -> Future<String, Error> {
        Future { promise in
            self.getEscapingClosure { returnedValue, error in
                if let error = error {
                    promise(.failure(error))
                } else {
                    promise(.success(returnedValue))
                }
            }
        }
    }

    func doSomething(completion: @escaping (_ value: String) -> Void) {
        DispatchQueue.main.asyncAfter(deadline: .now() + 4) {
            completion("NEW STRING")
        }
    }

    func doSomethingInTheFuture() -> Future<String, Never> {
        Future { promise in
            self.doSomething { value in
                promise(.success(value))
            }
        }
    }
}

struct FuturesBootcamp: View {
    @StateObject private var vm = FuturesBootcampViewModel()

    var body: some View {
        Text(vm.title)
    }
}

#Preview {
    FuturesBootcamp()
}

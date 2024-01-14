//
//  AsyncAwait.swift
//  Utils
//
//  Created by Jmy on 2023/09/08.
//

import SwiftUI
// test
struct AsyncAwait: View {
    @StateObject private var viewModel = AsyncAwaitViewModel()

    var body: some View {
        List {
            ForEach(viewModel.dataArray, id: \.self) { data in
                Text(data)
                    .font(.headline)
                    .fontWeight(.bold)
            }
        }
        .onAppear {
            Task {
                await viewModel.addAuthor1()
                await viewModel.addSomething()
                let finalText = "FinalText : \(Thread.current)"
                viewModel.dataArray.append(finalText)
            }
        }
    }
}

#Preview {
    AsyncAwait()
}

import SwiftUI

final class AsyncAwaitViewModel: ObservableObject {
    @Published var dataArray = [String]()

    func addTitle1() {
        dataArray.append("TITLE1 : \(Thread.current)\nIs Main? : \(Thread.isMainThread)")
    }

    func addTitle2() {
        DispatchQueue.global().asyncAfter(deadline: .now() + 2) {
            let title2 = "TITLE2 : \(Thread.current)\nIs Main? : \(Thread.isMainThread)"
            DispatchQueue.main.asyncAfter(deadline: .now() + 2) {
                self.dataArray.append(title2)
                self.dataArray.append("Title3: \(Thread.current)\nIs Main? : \(Thread.isMainThread)")
            }
        }
    }

    func addAuthor1() async {
        let author1 = "Author1 : \(Thread.current)"
        dataArray.append(author1)
        try? await Task.sleep(nanoseconds: 2000000000)
        // after sleep -> thread : not main thread
//        try? await doSometing()
        // await -> suspension point
        let author2 = "Author2: \(Thread.current)"
        // after sleep -> thread : main thread
        await MainActor.run(body: {
            self.dataArray.append(author2)
            let author3 = "Author3: \(Thread.current)"
            self.dataArray.append(author3)
        })
        await addSomething()
    }

    func doSometing() async throws {
        print("do Something")
    }

    func addSomething() async {
        try? await Task.sleep(nanoseconds: 2000000000)
        let something1 = "Something1 : \(Thread.current)"
        await MainActor.run(body: {
            self.dataArray.append(something1)

            let something2 = "Something2 : \(Thread.current)"
            self.dataArray.append(something2)
        })
    }
}

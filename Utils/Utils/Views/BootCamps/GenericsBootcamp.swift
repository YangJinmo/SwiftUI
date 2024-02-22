//
//  GenericsBootcamp.swift
//  Utils
//
//  Created by Jmy on 2/22/24.
//

import SwiftUI

struct StringModel {
    let info: String?

    func removeInfo() -> StringModel {
        StringModel(info: nil)
    }
}

class GenericsViewModel: ObservableObject {
//    @Published var dataArray: [String] = []
//
//    init() {
//        dataArray = ["one", "two", "three"]
//    }
//
//    func removeDataFromDataArray() {
//        dataArray.removeAll()
//    }

    @Published var stringModel = StringModel(info: "Hello, world!")

    func removeData() {
        stringModel = stringModel.removeInfo()
    }
}

struct GenericsBootcamp: View {
    @StateObject private var vm = GenericsViewModel()

    var body: some View {
        VStack {
//            ForEach(vm.dataArray, id: \.self) { item in
//                Text(item)
//                    .onTapGesture {
//                        vm.removeDataFromDataArray()
//                    }
//            }
            Text(vm.stringModel.info ?? "no data")
                .onTapGesture {
                    vm.removeData()
                }
        }
    }
}

#Preview {
    GenericsBootcamp()
}

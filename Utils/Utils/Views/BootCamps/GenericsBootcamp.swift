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

struct BoolModel {
    let info: Bool?

    func removeInfo() -> BoolModel {
        BoolModel(info: nil)
    }
}

struct GenericModel<T> {
    let info: T?

    func removeInfo() -> GenericModel {
        GenericModel(info: nil)
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
    @Published var boolModel = BoolModel(info: true)

    @Published var genericStringModel = GenericModel(info: "Hello, world!")
    @Published var genericBoolModel = GenericModel(info: true)

    func removeData() {
        stringModel = stringModel.removeInfo()
        boolModel = boolModel.removeInfo()
        genericStringModel = genericStringModel.removeInfo()
        genericBoolModel = genericBoolModel.removeInfo()
    }
}

struct GenericView<T: View>: View {
    let content: T
    let title: String

    var body: some View {
        VStack {
            Text(title)

            content
        }
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
            Text(vm.boolModel.info?.description ?? "no data")
            Text(vm.genericStringModel.info ?? "no data")
            Text(vm.genericBoolModel.info?.description ?? "no data")

            GenericView(content: Text("custom content"), title: "new view!")
        }
        .onTapGesture {
            vm.removeData()
        }
    }
}

#Preview {
    GenericsBootcamp()
}

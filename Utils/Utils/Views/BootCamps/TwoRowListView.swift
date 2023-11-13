//
//  TwoRowListView.swift
//  Utils
//
//  Created by Jmy on 2023/11/07.
//

import SwiftUI

class TwoRowListViewModel: ObservableObject {
    var alphabets = [
        ["A", "B", "C", "D", "E", "F", "G"],
        ["H", "I", "J", "K", "L", "M", "N", "O", "P"],
        ["Q", "R", "S", "T", "U", "V"],
        ["W", "X", "Y", "Z"],
    ]
}

struct TwoRowListView: View {
    @ObservedObject private var viewModel = TwoRowListViewModel()
    @State private var indexPath: IndexPath?
    @State private var selection: Bool? = false

    var body: some View {
        NavigationView {
            VStack {
                NavigationLink(
                    destination: destinationView,
                    tag: true,
                    selection: $selection,
                    label: { EmptyView() }
                )

                List {
                    ForEach(Array(viewModel.alphabets.enumerated()), id: \.element) { section, row in
                        ScrollView(.horizontal) {
                            HStack {
                                ForEach(Array(row.enumerated()), id: \.element) { item, value in
                                    VStack {
                                        Text(value)
                                            .font(.largeTitle)

                                        Text("[\(section), \(item)]")
                                    }
                                    .frame(width: 180, height: 180, alignment: .center)
                                    .background(
                                        indexPath == IndexPath(item: item, section: section)
                                            ? Color.green
                                            : Color.yellow
                                    )
                                    .onTapGesture {
                                        indexPath = IndexPath(item: item, section: section)
                                        selection = true
                                    }
                                }
                            }
                        }
                    }
                }
            }
        }
    }

    var destinationView: some View {
        VStack {
            if let indexPath = indexPath {
                Text(viewModel.items[indexPath.section][indexPath.item])
                    .font(.largeTitle)

                Text(indexPath.description)
            }
        }
    }
}

#Preview {
    TwoRowListView()
}

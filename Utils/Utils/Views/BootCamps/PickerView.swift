//
//  PickerView.swift
//  Utils
//
//  Created by Jmy on 8/7/24.
//

import SwiftUI

enum Flavor: String, CaseIterable, Identifiable {
    case chocolate, vanilla, strawberry
    var id: Self { self }
}

enum Topping: String, CaseIterable, Identifiable {
    case nuts, cookies, blueberries
    var id: Self { self }
}

extension Flavor {
    var suggestedTopping: Topping {
        switch self {
        case .chocolate: return .nuts
        case .vanilla: return .cookies
        case .strawberry: return .blueberries
        }
    }
}

struct PickerView: View {
    let options = ["전체", "추천순", "거리순"]

    @State private var selectedOption = 0
    @State private var selectedFlavor: Flavor = .chocolate
    @State private var suggestedTopping: Topping = .nuts
    @State private var selectedTopping: Topping = .nuts

    var body: some View {
        VStack {
            Picker("정렬 옵션", selection: $selectedOption) {
                ForEach(options.indices, id: \.self) { index in
                    Text(options[index]).tag(index)
                }
            }
            .pickerStyle(SegmentedPickerStyle())
            .padding()

            Text("선택된 옵션: \(options[selectedOption])")

            List {
                Picker("Flavor", selection: $selectedFlavor) {
                    Text("Chocolate").tag(Flavor.chocolate)
                    Text("Vanilla").tag(Flavor.vanilla)
                    Text("Strawberry").tag(Flavor.strawberry)
                }
            }

            List {
                Picker(selection: $selectedFlavor) {
                    Text("Chocolate").tag(Flavor.chocolate)
                    Text("Vanilla").tag(Flavor.vanilla)
                    Text("Strawberry").tag(Flavor.strawberry)
                } label: {
                    Text("Flavor")
                    Text("Choose your favorite flavor")
                }
            }

            Picker("Flavor", selection: $selectedFlavor) {
                ForEach(Flavor.allCases) { flavor in
                    Text(flavor.rawValue.capitalized)
                }
            }

            List {
                Picker("Flavor", selection: $suggestedTopping) {
                    ForEach(Flavor.allCases) { flavor in
                        Text(flavor.rawValue.capitalized)
                            .tag(flavor.suggestedTopping)
                    }
                }
                HStack {
                    Text("Suggested Topping")
                    Spacer()
                    Text(suggestedTopping.rawValue.capitalized)
                        .foregroundStyle(.secondary)
                }
            }

            VStack {
                Picker("Flavor", selection: $selectedFlavor) {
                    ForEach(Flavor.allCases) { flavor in
                        Text(flavor.rawValue.capitalized)
                    }
                }
                Picker("Topping", selection: $selectedTopping) {
                    ForEach(Topping.allCases) { topping in
                        Text(topping.rawValue.capitalized)
                    }
                }
            }
            .pickerStyle(.segmented)
            .padding()
        }
    }
}

#Preview {
    PickerView()
}

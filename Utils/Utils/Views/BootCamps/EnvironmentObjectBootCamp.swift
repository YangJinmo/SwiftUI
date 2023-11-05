//
//  EnvironmentObjectBootCamp.swift
//  Utils
//
//  Created by Jmy on 2023/11/04.
//

import SwiftUI

class EnvironmentViewModel: ObservableObject {
    @Published var dataArray: [String] = []

    init() {
        getData()
    }

    func getData() {
        dataArray.append(contentsOf: ["iPhone", "iPad", "iMac", "Apple Watch"])
    }
}

struct EnvironmentObjectBootCamp: View {
    @StateObject var viewModel: EnvironmentViewModel = EnvironmentViewModel()

    var body: some View {
        NavigationView {
            List {
                ForEach(viewModel.dataArray, id: \.self) { item in
                    NavigationLink {
                        DetailView(selectedItem: item)
                    } label: {
                        Text(item)
                    }
                }
            }
            .navigationTitle("iOS Devices")
        }
        .environmentObject(viewModel)
    }
}

struct DetailView: View {
    let selectedItem: String

    var body: some View {
        ZStack {
            Color.orange.ignoresSafeArea()

            NavigationLink {
                FinalView()
            } label: {
                Text(selectedItem)
                    .font(.headline)
                    .foregroundColor(.orange)
                    .padding()
                    .padding(.horizontal)
                    .background(Color.white)
                    .cornerRadius(30)
            }
        }
    }
}

struct FinalView: View {
    @EnvironmentObject var viewModel: EnvironmentViewModel

    var body: some View {
        ZStack {
            LinearGradient(
                gradient: Gradient(colors: [Color.red, Color.blue]),
                startPoint: .topLeading,
                endPoint: .bottomTrailing
            )
            .ignoresSafeArea()

            ScrollView {
                VStack(spacing: 20) {
                    ForEach(viewModel.dataArray, id: \.self) { item in
                        Text(item)
                    }
                }
                .foregroundColor(.white)
                .font(.largeTitle)
            }
        }
    }
}

struct EnvironmentObjectBootCamp_Previews: PreviewProvider {
    static var previews: some View {
        EnvironmentObjectBootCamp()
    }
}

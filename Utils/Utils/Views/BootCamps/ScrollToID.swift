//
//  ScrollToID.swift
//  Utils
//
//  Created by Jmy on 2023/07/25.
//

import SwiftUI

struct ScrollToID: View {
    @State private var textFieldText: String = ""
    @State private var scrollToIndex: Int = 0

    var body: some View {
        VStack {
            TextField("Enter a # here...", text: $textFieldText)
                .frame(height: 55)
                .border(.gray)
                .padding(.horizontal)
                .keyboardType(.numberPad)

            Button("SCROLL NOW") {
                withAnimation(.spring()) {
                    if let index = Int(textFieldText) {
                        scrollToIndex = index
                    }
                }
            }

            ScrollView {
                ScrollViewReader { proxy in
                    ForEach(0 ..< 50) { index in
                        Text("This is item #\(index)")
                            .font(.headline)
                            .frame(height: 200)
                            .frame(maxWidth: .infinity)
                            .background(.white)
                            .cornerRadius(10)
                            .shadow(radius: 10)
                            .padding()
                            .id(index)
                    }
                    .onChange(of: scrollToIndex) { newValue in
                        proxy.scrollTo(newValue, anchor: .center)
                    }
                }
            }
        }
    }
}

#Preview {
    ScrollToID()
}

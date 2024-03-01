//
//  PreferenceKeyBootcamp.swift
//  Utils
//
//  Created by Jmy on 2/29/24.
//

import SwiftUI

struct PreferenceKeyBootcamp: View {
    @State private var text: String = "Hello, world!"

    var body: some View {
        NavigationView {
            VStack {
                SecondaryScreen(text: text)
                    .navigationTitle("Navigation Title")
                // .preference(key: CustomTitlePreferenceKey.self, value: "NEW VALUE")
                // .customTitle("New Value!!!")
            }
        }
        .onPreferenceChange(CustomTitlePreferenceKey.self, perform: { value in
            self.text = value
        })
    }
}

extension View {
    func customTitle(_ text: String) -> some View {
        preference(key: CustomTitlePreferenceKey.self, value: text)
    }
}

#Preview {
    PreferenceKeyBootcamp()
}

struct SecondaryScreen: View {
    let text: String
    @State private var newValue: String = ""

    var body: some View {
        Text(text)
            .onAppear(perform: getDataFromDatabase)
            .customTitle(newValue)
    }

    func getDataFromDatabase() {
        DispatchQueue.main.asyncAfter(deadline: .now() + 2.0) {
            self.newValue = "NEW VALUE FROM DATABASE"
        }
    }
}

struct CustomTitlePreferenceKey: PreferenceKey {
    static var defaultValue: String = ""

    static func reduce(value: inout String, nextValue: () -> String) {
        value = nextValue()
    }
}

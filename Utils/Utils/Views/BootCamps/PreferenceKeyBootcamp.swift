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
                    .customTitle("New Value!!!")
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

    var body: some View {
        Text(text)
    }
}

struct CustomTitlePreferenceKey: PreferenceKey {
    static var defaultValue: String = ""

    static func reduce(value: inout String, nextValue: () -> String) {
        value = nextValue()
    }
}

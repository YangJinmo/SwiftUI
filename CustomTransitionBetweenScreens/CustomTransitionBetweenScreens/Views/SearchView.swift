//
//  SearchView.swift
//  CustomTransitionBetweenScreens
//
//  Created by Jmy on 2023/05/18.
//

import SwiftUI

struct SearchView: View {
    @State var text = ""

    var body: some View {
        NavigationView {
            List(0 ..< 5) { _ in
                Text("Hello, World!")
            }
            .searchable(text: $text, placement: .navigationBarDrawer(displayMode: .always), prompt: Text("SwiftUI, React, UI Design"))
            .navigationTitle("Search")
            .navigationBarTitleDisplayMode(.inline)
        }
    }
}

struct SearchView_Previews: PreviewProvider {
    static var previews: some View {
        SearchView()
    }
}

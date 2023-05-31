//
//  SearchView.swift
//  DesignCode
//
//  Created by Jmy on 2023/05/31.
//

import SwiftUI

struct SearchView: View {
    @State var text = ""
    @Environment(\.presentationMode) var presentationMode

    var body: some View {
        NavigationView {
            List {
                ForEach(courses.filter { $0.title.localizedCaseInsensitiveContains(text) || text.isEmpty }) { item in
                    Text(item.title)
                }
            }
            .searchable(
                text: $text,
                placement: .navigationBarDrawer(displayMode: .always),
                prompt: Text("SwiftUI, React, UI Design")
            )
            .navigationTitle("Search")
            .navigationBarTitleDisplayMode(.inline)
            .navigationBarItems(trailing:
                Button {
                    presentationMode.wrappedValue.dismiss()
                } label: {
                    Text("Done").bold()
                }
            )
        }
    }
}

struct SearchView_Previews: PreviewProvider {
    static var previews: some View {
        SearchView()
    }
}

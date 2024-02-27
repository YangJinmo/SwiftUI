//
//  ViewBuilderBootcamp.swift
//  Utils
//
//  Created by Jmy on 2/25/24.
//

import SwiftUI

struct HeaderViewRegular: View {
    let title: String
    let description: String?
    let iconName: String?

    var body: some View {
        VStack(alignment: .leading, content: {
            Text(title)
                .font(.largeTitle)
                .fontWeight(.semibold)
            if let description = description {
                Text(description)
                    .font(.callout)
            }

            if let iconName = iconName {
                Image(systemName: iconName)
            }

            RoundedRectangle(cornerRadius: 5)
                .frame(height: 2)
        })
        .frame(maxWidth: .infinity, alignment: .leading)
        .padding()
    }
}

struct HeaderViewGeneric<Content: View>: View {
    let title: String
    let content: Content

    init(title: String, @ViewBuilder content: () -> Content) {
        self.title = title
        self.content = content()
    }

    var body: some View {
        VStack(alignment: .leading, content: {
            Text(title)
                .font(.largeTitle)
                .fontWeight(.semibold)

            content

            RoundedRectangle(cornerRadius: 5)
                .frame(height: 2)
        })
        .frame(maxWidth: .infinity, alignment: .leading)
        .padding()
    }
}

struct ViewBuilderBootcamp: View {
    var body: some View {
        VStack {
            HeaderViewRegular(title: "New Title", description: "Hello", iconName: "heart.fill")

            HeaderViewRegular(title: "Another Title", description: nil, iconName: nil)

//            HeaderViewGeneric(title: "Generic Title", content: Text("hello"))
//
//            HeaderViewGeneric(title: "Generic Title 2", content: Image(systemName: "heart.fill"))
//
//            HeaderViewGeneric(title: "Generic Title 3", content:
//                HStack {
//                    Text("hellooooo")
//
//                    Image(systemName: "bolt.fill")
//                }
//            )

            HeaderViewGeneric(title: "Generic Title") {
                HStack {
                    Text("hellooooo")

                    Image(systemName: "bolt.fill")
                }
            }

            Spacer()
        }
    }
}

#Preview {
    ViewBuilderBootcamp()
}

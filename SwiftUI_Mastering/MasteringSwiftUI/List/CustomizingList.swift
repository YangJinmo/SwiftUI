//
//  Mastering SwiftUI
//  Copyright (c) KxCoding <help@kxcoding.com>
//
//  Permission is hereby granted, free of charge, to any person obtaining a copy
//  of this software and associated documentation files (the "Software"), to deal
//  in the Software without restriction, including without limitation the rights
//  to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
//  copies of the Software, and to permit persons to whom the Software is
//  furnished to do so, subject to the following conditions:
//
//  The above copyright notice and this permission notice shall be included in
//  all copies or substantial portions of the Software.
//
//  THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
//  IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
//  FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
//  AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
//  LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
//  OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN
//  THE SOFTWARE.
//

import SwiftUI

struct HeaderView: View {
    let title: String
    let imageName: String

    var body: some View {
        HStack {
            Image(systemName: imageName)
                .font(.title)

            Text(title)
                .font(.title)
        }
        .frame(height: 60)
    }
}

struct CustomizingList: View {
    var body: some View {
        VStack {
            Text("Customizing List")
                .font(.largeTitle)
                .listRowBackground(Color.red)

            List {
                // Section(header: Text("header")) {
                Section(header: HeaderView(title: "Lorem Ipsum", imageName: "star")) {
                    Text("Hello, List!")
                    Text("List Row Insets")
                        .listRowInsets(.init(top: 0, leading: 100, bottom: 0, trailing: 0))
                    // 내부의 listRowInsets의 우선 순위가 더 높음
                    Text("List Row Background")
                        // .listRowBackground(Circle())
                        .listRowBackground(Color.yellow)
                }
                .listRowInsets(.init(top: 0, leading: 60, bottom: 0, trailing: 0))
                .listRowBackground(Color.blue)

                Section {
                    Text("One")
                    Text("Two")
                }
            }
            .listStyle(GroupedListStyle())
            // .listRowInsets(.init(top: 0, leading: 60, bottom: 0, trailing: 0))
            // X listRowInsets은 리스트에 적용할 수 없음
        }
    }
}

struct CustomizingList_Previews: PreviewProvider {
    static var previews: some View {
        CustomizingList()
    }
}

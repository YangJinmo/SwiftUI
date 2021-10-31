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

struct Nav_NavigationView: View {
    @State private var barHidden = false

    @State private var push = false

    var body: some View {
        NavigationView {
            VStack {
                Button(action: {
                    // self.barHidden.toggle()
                    self.push = true
                }, label: {
                    Text("Toggle Navigation Bar")
                })
                    .padding()

                NavigationLink(destination: NumberScene(number: 1, color: .blue), label: {
                    Text("Push")
                })
                    .padding()

                NavigationLink(destination: ColorScene(showSheet: $push), isActive: $push, label: {
                    Text("Push")
                })
                    .padding()
            }
            // .navigationBarTitle("Navigation View", displayMode: .inline)
            .navigationBarTitle("Navigation View")
            .navigationBarHidden(barHidden)
            .navigationBarItems(leading: Button("close", action: { }), trailing: TrailingButtonView())
        }
    }
}

struct Nav_NavigationView_Previews: PreviewProvider {
    static var previews: some View {
        Nav_NavigationView()
    }
}

struct TrailingButtonView: View {
    var body: some View {
        HStack {
            Button(action: { }, label: {
                Image(systemName: "square.and.arrow.up")
            })
            Toggle(isOn: .constant(true), label: {
                Text("Toggle")
            })
                .labelsHidden()
        }
    }
}

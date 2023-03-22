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

struct Nav_Popover: View {
    @State private var showPopover = false

    var body: some View {
        VStack {
            Button(action: {
                self.showPopover.toggle()
            }, label: {
                Text("Show Popover")
            })
            .padding()
//            .popover(isPresented: $showPopover, attachmentAnchor: .rect(Anchor<CGRect>.Source.bounds), arrowEdge: .top) {
//                NumberScene(number: 1, color: Color.blue)
//                    .frame(minWidth: 200, minHeight: 200)

//            .popover(isPresented: $showPopover, attachmentAnchor: .rect(Anchor<CGRect>.Source.rect(.zero)), arrowEdge: .top) {
//                NumberScene(number: 1, color: Color.blue)
//                    .frame(minWidth: 200, minHeight: 200)
//
            .popover(isPresented: $showPopover, attachmentAnchor: .point(.bottomTrailing), arrowEdge: .bottom) {
                NumberScene(number: 1, color: Color.blue)
                    .frame(minWidth: 200, minHeight: 200)
            }
        }
        .navigationBarTitle("Popover")
    }
}

struct Nav_Popover_Previews: PreviewProvider {
    static var previews: some View {
        NavigationView {
            Nav_Popover()
        }
    }
}

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

struct FontStyle: View {
    private var size: CGFloat = 40
    
    var body: some View {
        ScrollView {
            VStack(spacing: 20) {
                Text("No Style")
                    .font(.system(size: size))

                Text("Bold")
                    .font(.system(size: size))
                    .bold()

                Text("Italic")
                    .font(.system(size: size))
                    .italic()

                Text("Underline")
                    .font(.system(size: size))
                    .underline()
                // .underline(false, color: nil)

                Text("Strikethrough")
                    .font(.system(size: size))
                    .strikethrough()
                // .strikethrough(false, color: nil)

                Text("123")
                    .font(.system(size: size))

                Text("Monospaced 123")
                    .font(Font.system(size: size).monospacedDigit())
                // 폰트에서만 지원하는 모디파이어는 이런식으로 사용해야 합니다.
                // 앞에 Font.도 넣어줘야 합니다.

                HStack {
                    Text("Small ")
                        .font(Font.system(size: size))

                    Text("Capitals")
                        .font(Font.system(size: size).smallCaps())
                }

                Text("Lower Small Caps")
                    .font(Font.system(size: size).lowercaseSmallCaps())

                Text("Upper Small Caps")
                    .font(Font.system(size: size).uppercaseSmallCaps())
            }
            .frame(maxWidth: .infinity)
        }
    }
}

struct FontStyle_Previews: PreviewProvider {
    static var previews: some View {
        FontStyle()
    }
}

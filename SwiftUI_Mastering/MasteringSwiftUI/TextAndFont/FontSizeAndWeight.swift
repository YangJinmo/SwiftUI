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

struct FontSizeAndWeight: View {
    private var size: CGFloat = 48

    var body: some View {
        ScrollView {
            VStack(spacing: 20) {
                Text("\(Int(size))pt Font")
                    .font(.system(size: size))

                Text("Black")
                    .font(.system(size: size, weight: .black))

                Text("Heavy")
                    .font(.system(size: size, weight: .heavy))

                Text("Bold")
                    .font(.system(size: size, weight: .bold))

                Text("Semibold")
                    .font(.system(size: size, weight: .semibold))

                Text("Medium")
                    .font(.system(size: size, weight: .medium))

                Text("Regular")
                    .font(.system(size: size, weight: .regular))

                Text("Light")
                    .font(.system(size: size, weight: .light))

                Text("Thin")
                    .font(.system(size: size, weight: .thin))

                Text("Ultra Light")
                    .font(.system(size: size, weight: .ultraLight))
//                 .fontWeight(.ultraLight)
            }
            .frame(maxWidth: .infinity)
        }
    }
}

struct FontSizeAndWeight_Previews: PreviewProvider {
    static var previews: some View {
        FontSizeAndWeight()
    }
}

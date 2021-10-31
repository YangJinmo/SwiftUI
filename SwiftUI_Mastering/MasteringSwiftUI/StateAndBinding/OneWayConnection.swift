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

struct OneWayConnection: View {
    // let text: String = "Hello"
    // var text: String = "Hello" // 'self' is immutable
    @State private var text: String = "Hello"

    // 구조체이기 때문에 값 형식
    // body: Computed Property (연산 프로퍼티)
    // @State를 붙여주어야 값 변경 가능
    // boby를 다시 호출해서 다시 그려줌
    // Source of Truth => @State variable
    // view에 접근하는 것은 State variable이기 때문에 보통 private로 선언
    var body: some View {
        VStack(spacing: 70) {
            Text(text)
                .font(.largeTitle)

            Button(action: {
                self.text = "SwiftUI"
            }, label: {
                Text("Update")
            })
                .padding()
        }
    }
}

struct OneWayBinding_Previews: PreviewProvider {
    static var previews: some View {
        OneWayConnection()
    }
}

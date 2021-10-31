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

struct TwoWayConnection: View {
    @State private var value: String = "Hello"

    var body: some View {
        VStack(spacing: 70) {
            Text(value)
                .font(.largeTitle)

            TextField("Input", text: $value) // $문자를 붙이면 바인딩이 리턴됨
                .padding()

            BindingButton(value: $value)
        }
    }
}

struct TwoWayConnection_Previews: PreviewProvider {
    static var previews: some View {
        Group {
            TwoWayConnection()
            BindingButton(value: .constant("Hello"))
        }
    }
}

struct BindingButton: View {
    // State Variable은 속성을 선언하고 있는 뷰가 소유하고 값을 저장할 공간을 가지고 있다.
    // Binding Variable은 다른 뷰의 속성을 연결할 뿐 소유권을 가지고 있지 않습니다. 값을 저장하는 공간도 가지고 있지 않습니다. 그래서 따로 초기화할 필요는 없습니다. 외부에서 전달받기 때문에 private로 선언하지 않습니다.
    @Binding var value: String

    var body: some View {
        Button(action: {
            self.value = "Hi~~"
        }, label: {
            Text(value)
        })
            .padding()
    }
}

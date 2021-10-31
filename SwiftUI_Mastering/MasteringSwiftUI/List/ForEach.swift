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

struct View_ForEach: View {
    var items = AppleProduct.sampleList

    var body: some View {
        VStack {
            // HStack {
            Text("ForEach")
                .font(.largeTitle)

            // id parameter: 배열 내에서 인스턴스를 구분하기위해 필요
            // AppleProduct 구조체는 Identifiable Protocol을 채용하고 있기 때문에
            // id parameter를 전달할 필요가 없음.

            // ForEach는 VStack에 임베드 되어 있다.
            // ForEach는 가장 인접한 Stack에 따라서 배치 방향을 결정합니다.

            ForEach(items) { item in
                Text(item.name)
            }
        }
    }
}

struct View_ForEach_Previews: PreviewProvider {
    static var previews: some View {
        View_ForEach()
    }
}

// List / ForEach

// ForEach
// - Sectioned List
// - Delete / Move
// - Grid UI

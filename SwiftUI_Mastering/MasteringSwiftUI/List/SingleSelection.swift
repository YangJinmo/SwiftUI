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

struct SingleSelection: View {
    var items = AppleProduct.sampleList

    @State private var selected: AppleProduct? = nil

    var body: some View {
        VStack {
            Text("Selected \(selected?.name ?? "-")")
                .font(.largeTitle)

//            List(items, selection: $selected) { item in
//                Button(action: {
//                    self.selected = item
//                }) {
//                    Text(item.name)
//                }
//            }

            /// 편집 모드가 아닌 일반 모드에서는 바인딩을 지원하지 않기 때문에
            /// 두번째 파라미터인 selection Parameter는 필요 없음
//            List(items) { item in
//                Button(action: {
//                    self.selected = item
//                }) {
//                    Text(item.name)
//                }
//            }

            /**
             selection으로 선택을 바인딩하려면
             리스트가 개별 항목을 구분하는 타입과
             바인딩한 State Variable이 똑같아야해요.
             AppleProduct 구조체를 보면 Identifiable 프로토콜을 채용하요 있죠
             그래서 아이디 속성으로 인스턴스를 구분하고
             아니디 속성은 UUID죠
             그런데 State Variable 형식은 Apple Product로 두 형식이 일치하지 않기 때문에
             편집모드로 전환되지 않아요
             그래서 selected의 형식을 바꾸거나
             리스트가 인스턴스 자체를 구분하도록 수정해야하는데
             여기에서는 두번째 방식으로 할게요. -> id: \.self
             - 단일 선택: SwiftUI.Binding<SelectionValue> - struct SingleSelection
             - 복수 선택: SwiftUI.Binding<Set<SelectionValue>>? - struct MultiSelection
             (왜인지 제대로 동작하지 않음)
             */
            List(items, id: \.self, selection: $selected) { item in
//                Button(action: {
                // self.selected = item
//                }) {
//                    Text(item.name)
//                }

                /// 편집모드에서는 탭이벤트가 자동으로 처리되니까 버튼이 없어도 됨.
                Text(item.name)
            }
        }
        .toolbar {
            #if os(iOS)
                EditButton()
            #endif
        }
//        .navigationBarItems(trailing: EditButton())
    }
}

struct ManagingSelection_Previews: PreviewProvider {
    static var previews: some View {
        NavigationView {
            SingleSelection()
        }
    }
}

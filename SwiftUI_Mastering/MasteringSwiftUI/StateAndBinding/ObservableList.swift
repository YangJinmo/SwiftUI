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

// ObservableObject: 감시가 가능한 객체
class SharedList: ObservableObject {
    var title = ""
    // @Published가 없다면 값이 바뀌어도 새로운 값을 방출하지 않습니다.
    // 그래서 이 속성을 바꾸는 것 만으로는 뷰가 업데이트 되지 않습니다.
    @Published var list = [String]()
    // @Published를 추가하면 배열의 새로운 요소가 추가되거나 삭제되는 시점마다 새로운 배열을 방출합니다.
    // ObservableObject에는 최소 1개 이상의 Published가 있어야 의미가 있다.
}

struct ObservableList: View {
    @State private var value: String = ""
    // State는 뷰 내부에 선언, Child에 Binding해서 사용
    @ObservedObject var sharedList = SharedList() // class instance
    // ObservedObject는 뷰 외부에 선언, 특정 뷰가 소유하지 않음. 저장 공간을 우리가 직접 관리.
    // 여기에서는 이 속성의 인스턴스를 직접 저장했지만,
    // Singleton으로 구현했다면 연관성이 없는 여러 개의 뷰에서 하나의 데이터를 쉽게 공유할 수 있습니다.

    var body: some View {
        VStack {
            Text(sharedList.title)
                .font(.largeTitle)

            HStack {
                TextField("Input", text: $value)
                    .textFieldStyle(RoundedBorderTextFieldStyle())
                    .padding()

                Button(action: {
                    self.sharedList.title = "Observable List"
                    self.sharedList.list.insert(self.value, at: 0)
                    self.value = ""
                }, label: {
                    Text("Add To List")
                })
                .padding()
            }

            List(sharedList.list, id: \.self) { item in
                Text(item)
            }

            Spacer()
        }
        .padding()
    }
}

struct ObservableList_Previews: PreviewProvider {
    static var previews: some View {
        ObservableList()
    }
}

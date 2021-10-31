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

struct ColorBasics: View {
    var body: some View {
        VStack {
            Text("Hello, SwiftUI Color!")
                .font(.largeTitle)

            Color.blue
            // Color 구조체는 View Protocol을 채용하고 있고
            // SwiftUI에서 View처럼 사용할 수 있습니다.
            // 그래서 frame이나 offset 같은 것들을 자유롭게 적용할 수 있습니다.
            // 지금처럼 frame을 고정하지 않는다면 사용가능한 영역 전체를 채웁니다.

            Color.yellow

            Color(.sRGB, red: 70.0 / 255.0, green: 53.0 / 255.0, blue: 99.0 / 255.0, opacity: 1.0)

            Color("myCustomColor") // 컬러 에셋에서 만든 네임드 컬러
        }
        .background(Color(UIColor.systemBackground))
        // Text가 모든 모드에서 정상적으로 표시되도록
        // VStack Backgound에 systemBackground Color를 적용합니다.
        // 우리가 사용해야하는 Dynamic Color는
        // UI Color Class에 선언 되어 있음.
        // 버전이 업데이트 된다면 컬러 구조체에도 모든 DynamicColor가 추가되겠지만
        // 현재는 UI Color에 선언 되어 있는 DynamicColor를 Color 구조체로 바꾸어서 사용해야 합니다.
        // 제공하는 Color 이 외의 Color를 사용하고 싶다면
        // Color 구조체가 4:17
    }
}

struct ColorBasics_Previews: PreviewProvider {
    static var previews: some View {
        Group {
            ColorBasics()
                .environment(\.colorScheme, .light)

            ColorBasics()
                .environment(\.colorScheme, .dark)
        }
    }
}

// SwiftUI는 다양한 System Color와 Dynamic Color를 제공합니다.
// 이런 Color들은 Color 구조체에 선언되어 있습니다.
// 그리고 실행 환경에 최적화된 컬러를 출력해줍니다.

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

// 앱을 만들다보면 여러 뷰에서 공통적으로 사용하는 공유 데이터가 필요합니다.
// 데이터가 뷰 계층에 자동으로 주입되기 때문에 비교적 쉽게 공유할 수 있습니다.
// 뷰 계층이 단순하다면 initializer로 전달하는 것도 문제는 없지만
// 뷰 계층이 복잡해지면 필요 이상으로 복잡해집니다.

// 미리 공유되어 있는 시스템 공유 데이터와 커스텀 공유 데이터로 구분합니다.
// 시스템 공유 데이터를 사용할 때는 @Environment 특성을 사용합니다.
// 커스텀 공유 데이터를 사용할 때는 @EnvironmentObject 특성을 사용합니다.
// 데이터가 업데이트되면 뷰를 자동으로 업데이트 합니다.

struct View_Environment: View {
    @Environment(\.colorScheme) var currentColorScheme
    // 뷰가 생성되는 시점에 colorScheme에 저장되어 있던 값이
    // 자동으로 currentColorScheme에 저장됩니다.
    // colorScheme: .light / .dark

    @Environment(\.horizontalSizeClass) var currentHorizontalSizeClass

    var body: some View {
        List {
            HStack {
                Text("Color Scheme")

                Spacer()

                Text(currentColorScheme == .dark ? "Dark Mode" : "Light Mode")
            }
            .padding()

            HStack {
                Text("Horizontal Size Class")

                Spacer()

                Text(currentHorizontalSizeClass == .compact ? "Compact" : "Regular")
            }
            .padding()
        }
    }
}

struct View_Environment_Previews: PreviewProvider {
    static var previews: some View {
        View_Environment()
            .environment(\.colorScheme, .dark)
    }
}

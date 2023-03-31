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

struct AnimationBasics: View {
    @State private var isAnimating: Bool = false
    @State private var position = CGPoint.zero

    var body: some View {
        VStack {
            Circle()
                .foregroundColor(.blue)
                .frame(width: 50, height: 50)
                .position(position)
                .offset(x: 50, y: 50)
                // .animation(.default)
                // .animation(.easeInOut(duration: 3))
                // .animation(Animation.easeInOut(duration: 3).delay(1))

                // FIX: - isAnimating을 추가하면 애니메이션이 동작하지 않는 문제
                // .animation(Animation.easeInOut(duration: 3).speed(2), value: isAnimating) // 3 / 2 의 실행시간: 1.5
                // .animation(Animation.easeInOut(duration: 3).speed(0.5)) // 3 * 2 의 실행시간: 6
                .animation(Animation.easeInOut(duration: 3).speed(2))

            Spacer()

            Button(action: {
                self.position = self.position == .zero ? CGPoint(x: 300, y: 500) : .zero

                withAnimation {
                    isAnimating.toggle()
                }
            }, label: {
                Text("Animate")
            })
            .padding()
        }
        .onAppear {
            isAnimating = true
        }
    }
}

struct AnimationBasics_Previews: PreviewProvider {
    static var previews: some View {
        AnimationBasics()
    }
}

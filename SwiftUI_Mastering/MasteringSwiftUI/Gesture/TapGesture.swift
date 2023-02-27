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

struct Gesture_TapGesture: View {
    @State private var tapCount = 0

    var tapToPlus: some Gesture {
        TapGesture()
            .onEnded {
                tapCount += 1
            }
    }

    var doubleTapToPlus10: some Gesture {
        TapGesture(count: 2)
            .onEnded {
                tapCount += 10
            }
    }

    var body: some View {
        VStack {
            Text("\(tapCount)")
                .font(.system(size: 250))
                .onTapGesture(count: 2) {
                    tapCount = 0
                }

            HStack {
                Image(systemName: "minus.circle")
                    .font(.system(size: 100))
                    .foregroundColor(.red)
                    .padding()
                    .onTapGesture {
                        tapCount -= 1
                    }
//                    .gesture(
//                        TapGesture()
//                            .onEnded({
//                                tapCount -= 1
//                            })
//                    )

                Image(systemName: "plus.circle")
                    .font(.system(size: 100))
                    .foregroundColor(.blue)
                    .padding()
                    .gesture(doubleTapToPlus10)
                    .gesture(tapToPlus)
                // https://youtu.be/cFuqJUL7e44
            }
        }
        .onTapGesture {
            print("VStack tapped - onTapGesture")
        }
        .simultaneousGesture(
            TapGesture()
                .onEnded {
                    print("VStack tapped - simultaneousGesture")
                }
        )
    }
}

struct TapGesture_Previews: PreviewProvider {
    static var previews: some View {
        Gesture_TapGesture()
    }
}

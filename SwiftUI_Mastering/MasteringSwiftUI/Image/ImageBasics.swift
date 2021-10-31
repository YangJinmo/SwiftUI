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

struct ImageBasics: View {
    var body: some View {
        VStack {
            Text("Image")
                .font(.title)

            // VoiceOver
            // 시각 장애인을 위해 마우스를 올려두면 어떤 항목인지 설명해주는 기능

            // Labeled Image
            Image("swiftui-logo")
                .resizable()
                .aspectRatio(contentMode: .fit)
                .frame(width: 200, height: 300)
            // Image("", bundle: nil)
            // Image("", bundle: nil, label: "")

            // Unlabeled Image
            // decorative
            // Image(decorative: "")

            // 기본적으로는 이미지 고유의 크기로 그려짐

            Image(systemName: "star")
                .resizable()
                .aspectRatio(contentMode: .fit)
                .frame(width: 200, height: 300)
                .foregroundColor(.yellow)

            HStack {
                Image(systemName: "person.crop.circle")
                    .font(.largeTitle)

                Text("Profile")
                    .font(.largeTitle)
            }
            .padding() // 패딩을 추가하면 클리핑 없이 문자가 모두 보여짐

            Spacer()
        }
    }
}

struct ImageBasics_Previews: PreviewProvider {
    static var previews: some View {
        ImageBasics()
    }
}

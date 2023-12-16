//
//  HelloView.swift
//  Utils
//
//  Created by Jmy on 2023/12/16.
//

import SwiftUI

protocol HelloProtocol {
    var helloworld1: String { get set }
    var helloworld2: String { get set }
    var helloworld3: String { get set }
}

extension HelloProtocol where Self: View {
    var body: some View {
        VStack {
            Text(helloworld1)
            Text(helloworld2)
            Text(helloworld3)
        }
    }
}

struct HelloView: View, HelloProtocol {
    @State var helloworld1: String = "Hello world1"
    @State var helloworld2: String = "Hello world2"
    @State var helloworld3: String = "Hello world3"
}

struct HelloView_Previews: PreviewProvider {
    static var previews: some View {
        HelloView()
    }
}

// View의 상태를 먼저 정의하고, View는 상태를 기반으로 화면에 보여줄 UI를 작성합니다.
// 상태와 View의 코드가 분리가 되어 있기 때문에 온전히 한 곳의 영역에만 집중해서 작업이 가능하다는 장점이 있습니다.
// 또한 Protocol로 상태를 정의하고, extension으로 view를 가지도록 할 수도 있습니다.
// https://youtu.be/Dxkr-bq1L28?si=8By6p24cEhi2CUY1

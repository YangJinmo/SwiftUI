//
//  ComposeScene.swift
//  SwiftUI_Memo
//
//  Created by Jmy on 2021/02/16.
//

import SwiftUI

struct ComposeScene: View {
    @EnvironmentObject var store: MemoStore
    // 입력한 테스트 바인딩 하는 속성으로 State 사용
    @State private var content: String = ""
    @Binding var showComposer: Bool

    var body: some View {
        NavigationView {
            VStack {
                // $content와 TextField가 바인딩 됨
                // TextField 에 문자를 입력하면 content에 저장됨
                // 2 way 바인딩
                TextField("", text: $content)
                    .background(Color.yellow)
            }
            .frame(maxWidth: .infinity, maxHeight: .infinity)
            .navigationBarTitle("새 메모", displayMode: .inline) // 기본이 라지 타이틀 ndisplayMode 지정해주면
            .navigationBarItems(
                leading: DismissButton(show: $showComposer),
                trailing: Savebutton(show: $showComposer, content: $content)
            )
        }
    }
}

fileprivate struct DismissButton: View {
    @Binding var show: Bool

    var body: some View {
        Button(action: {
            self.show = false
        }, label: {
            Text("취소")
        })
    }
}

fileprivate struct Savebutton: View {
    @Binding var show: Bool

    // 자동으로 주입되도록
    @EnvironmentObject var store: MemoStore
    // 입력한 값
    @Binding var content: String

    var body: some View {
        Button(action: {
            self.store.insert(memo: self.content)
            self.show = false
        }, label: {
            Text("저장")
        })
    }
}

struct ComposeScene_Previews: PreviewProvider {
    static var previews: some View {
        ComposeScene(showComposer: .constant(false)).environmentObject(MemoStore())
    }
}

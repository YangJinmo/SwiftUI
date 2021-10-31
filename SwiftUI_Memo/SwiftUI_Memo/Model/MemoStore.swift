//
//  MemoStore.swift
//  SwiftUI_Memo
//
//  Created by Jmy on 2021/02/01.
//

import Foundation

class MemoStore: ObservableObject {
    @Published var list: [Memo] // Published - 배열을 업데이트 할때마다 바인딩되어 있는 뷰도 함께 업데이트 됨

    init() {
        list = [
            Memo(content: "Lorem Ipsum 1"),
            Memo(content: "Lorem Ipsum 2"),
            Memo(content: "Lorem Ipsum 3"),
        ] // 더미데이터 추가
    }

    // CRUD
    // memo create
    func insert(memo: String) {
        list.insert(Memo(content: memo), at: 0) // 새로운 메모는 항상 0번에 저장. 그럼 항상 위에 생기겠죠?
    }

    // memo update
    func update(memo: Memo?, content: String) {
        guard let memo = memo else { return }
        memo.content = content
    }

    // memo delete - memo 인스턴스를 받는 버전
    func delete(memo: Memo) {
        DispatchQueue.main.async {
            self.list.removeAll { $0 == memo }
        }
    }

    // memo delete - indexset을 받는 버전
    func delete(set: IndexSet) {
        for index in set {
            list.remove(at: index)
        }
    }
}

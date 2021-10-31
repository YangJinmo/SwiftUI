//
//  Memo.swift
//  SwiftUI_Memo
//
//  Created by Jmy on 2021/02/01.
//

import SwiftUI

// Identifiable 채택하면 데이터 목록을 테이블뷰나 컬렉션뷰로 쉽게 바인딩할 수 있음
// ObservableObject 반응형 UI를 만들기 위해 필요
class Memo: Identifiable, ObservableObject {
    let id: UUID // Identifiable 요구하는 속성, 메모를 구분할때 사용
    @Published var content: String // 메모 내용 저장, Published - 새로운 값이 저장될때 마다 바인딩되어 있는 유아이가 자동으로 업데이트 됨
    let insertDate: Date // 메모 생성한 날짜 저장

    init(id: UUID = UUID(), content: String, insertDate: Date = Date()) {
        self.id = id
        self.content = content
        self.insertDate = insertDate
    }
}

extension Memo: Equatable {
    static func == (lhs: Memo, rhs: Memo) -> Bool {
        return lhs.id == rhs.id
    }
}

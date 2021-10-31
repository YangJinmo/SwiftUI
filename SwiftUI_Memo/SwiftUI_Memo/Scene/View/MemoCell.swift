//
//  MemoCell.swift
//  SwiftUI_Memo
//
//  Created by Jmy on 2021/02/10.
//

import SwiftUI

struct MemoCell: View {
    // 생성자로 전달받은 메모를 저장
    // ObservedObject 메모객체가 업데이트되는 시점마다 뷰가 업데이트됨
    // 항상 최신데이터 표시
    @ObservedObject var memo: Memo
    @EnvironmentObject var formatter: DateFormatter

    var body: some View {
        VStack(alignment: .leading) {
            Text(memo.content)
                .font(.body)
                .lineLimit(1)

            Text("\(memo.insertDate, formatter: self.formatter)")
                .font(.caption)
                .foregroundColor(Color(UIColor.secondaryLabel))
        }
    }
}

struct MemoCell_Previews: PreviewProvider {
    static var previews: some View {
        MemoCell(memo: Memo(content: "Tesst"))
            .environmentObject(DateFormatter.memoDateFormatter)
    }
}

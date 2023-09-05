//
//  ReusableListView.swift
//  Utils
//
//  Created by Jmy on 2023/09/04.
//

import SwiftUI

struct ReusableListView<L: ListableResponseModel>: View {
    let data: [L]

    var body: some View {
        List(data) { object in
            HStack {
                VStack(alignment: .leading) {
                    Text(object.titleString)

                    if let subtitle = object.subtitleString {
                        Text(subtitle)
                    }
                }

                if let detail = object.detailString {
                    Spacer()
                    Text(detail)
                }
            }
        }
    }
}

struct ReusableListView_Previews: PreviewProvider {
    static var previews: some View {
        ReusableListView(data: models)
        ReusableListView(data: primeMinisters)
    }
}

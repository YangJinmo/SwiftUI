//
//  PhoneModelsListView.swift
//  Utils
//
//  Created by Jmy on 2023/09/04.
//

import SwiftUI

let models: [PhoneModel] = [
    PhoneModel(name: "iPhone 13 Pro", releaseDate: "2021-09-14", screenResolution: PhoneModel.ScreenResolution(height: 844, width: 390)),
    PhoneModel(name: "iPhone 6s Plus", releaseDate: "2015-09-25", screenResolution: PhoneModel.ScreenResolution(height: 847, width: 476)),
]

struct PhoneModelsListView: View {
    var body: some View {
        List(models) {
            Text($0.name ?? "")
        }
        List(primeMinisters) {
            Text($0.name ?? "")
        }
    }
}

#Preview {
    PhoneModelsListView()
}

//
//  CurrentTimeView.swift
//  Utils
//
//  Created by Jmy on 2023/06/28.
//

import SwiftUI

struct CurrentTimeView: View {
    @State private var currentDate = Date()
    let timer = Timer.publish(every: 1, on: .main, in: .common).autoconnect()

    var body: some View {
        Text("\(currentDate)")
            .onReceive(timer) { input in
                self.currentDate = input
            }
    }
}

struct CurrentTimeView_Previews: PreviewProvider {
    static var previews: some View {
        CurrentTimeView()
    }
}

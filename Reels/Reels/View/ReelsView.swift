//
//  ReelsView.swift
//  Reels
//
//  Created by Jmy on 2023/03/08.
//

import SwiftUI

struct ReelsView: View {
    @State var currentReel = ""

    var body: some View {
        GeometryReader { proxy in
            let size = proxy.size

            TabView(selection: $currentReel) {
                ForEach(mediaFiles) { _ in
                    Color.red
                        .padding()
                }
            }
            .rotationEffect(.degrees(90))
            .frame(width: size.height)
            .tabViewStyle(.page(indexDisplayMode: .never))
            .frame(width: size.width)
        }
    }
}

struct ReelsView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}

//
//  GeometryReaderView.swift
//  Utils
//
//  Created by Jmy on 2023/06/23.
//

import SwiftUI

struct GeometryReaderView: View {
    var body: some View {
        GeometryReader { geometry in
            Text("width: \(geometry.size.width)\nheight: \(geometry.size.height)")
                .frame(
                    width: geometry.size.width,
                    height: geometry.size.height
                )
                .foregroundColor(.gray300)
                .border(Color.limeGreen)
        }
    }
}

struct GeometryReaderView_Previews: PreviewProvider {
    static var previews: some View {
        GeometryReaderView()
    }
}

//
//  CustomShapeBootcamp.swift
//  Utils
//
//  Created by Jmy on 2/13/24.
//

import SwiftUI

struct CustomShapeBootcamp: View {
    var body: some View {
        ZStack {
            Rectangle()
                .trim(from: 0, to: 0.5)
                .frame(width: 300, height: 300)
        }
    }
}

#Preview {
    CustomShapeBootcamp()
}

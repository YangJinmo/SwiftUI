//
//  Home.swift
//  Animated Header
//
//  Created by Jmy on 2023/02/27.
//

import SwiftUI

struct Home: View {
    var body: some View {
        ScrollView {
            // Since Were Pinning Header View
            LazyVStack(
                alignment: .leading,
                pinnedViews: [.sectionHeaders],
                content: {
                    // Cards
                    Section(header: HeaderView()) {
                        ForEach(foods) { food in
                            CardView(food: food)
                        }
                    }
                }
            )
        }
    }
}

struct Home_Previews: PreviewProvider {
    static var previews: some View {
        Home()
    }
}

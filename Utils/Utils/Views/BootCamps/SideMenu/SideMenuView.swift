//
//  SideMenuView.swift
//  Utils
//
//  Created by Jmy on 3/27/25.
//

import SwiftUI

struct SideMenuView: View {
    @Binding var isShowing: Bool
    @Binding var selectedTab: Int
    @State private var selectedOption: SideMenuOptionModel?

    var body: some View {
        ZStack(alignment: .topLeading) {
            if isShowing {
                Rectangle()
                    .opacity(0.3)
                    .ignoresSafeArea()
                    .onTapGesture {
                        isShowing.toggle()
                    }

                HStack {
                    VStack(alignment: .leading, spacing: 0) {
                        SideMenuHeaderView()
                            .padding(.bottom, 8)

                        ForEach(SideMenuOptionModel.allCases, id: \.self) { option in
                            Button {
                                selectedOption = option
                                selectedTab = option.rawValue
                            } label: {
                                SideMenuRowView(option: option, selectedOption: $selectedOption)
                            }
                        }

                        Spacer()
                    }
                    .padding()
                    .frame(width: 280, alignment: .leading)
                    .background(.white)

                    Spacer()
                }
                .transition(.move(edge: .leading))
            }
        }
        .animation(.easeInOut, value: isShowing)
    }
}

#Preview {
    SideMenuView(isShowing: .constant(true), selectedTab: .constant(0))
}

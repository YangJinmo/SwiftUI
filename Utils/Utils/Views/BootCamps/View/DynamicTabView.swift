//
//  DynamicTabView.swift
//  Utils
//
//  Created by Jmy on 12/9/24.
//

import SwiftUI

struct DynamicTabView: View {
    @State private var selectedTab = 0
    @State private var tabOffset: CGFloat = 0

    private let tabs = ["Tab 1", "Tab 2", "Tab 3"]

    var body: some View {
        VStack(spacing: 0) {
            // Tab Buttons
            HStack(spacing: 0) {
                ForEach(0 ..< tabs.count, id: \.self) { index in
                    Button(action: {
                        withAnimation(.spring()) {
                            selectedTab = index
                        }
                    }) {
                        Text(tabs[index])
                            .font(.system(size: 16, weight: .semibold))
                            .foregroundColor(selectedTab == index ? .primary : .gray)
                            .padding(.vertical, 12)
                            .frame(maxWidth: .infinity)
                    }
                }
            }
            .overlay(alignment: .bottomLeading) {
                // Dynamic Indicator
                Capsule()
                    .fill(Color.accentColor)
                    .frame(width: UIScreen.main.bounds.width / CGFloat(tabs.count), height: 3)
                    .offset(x: tabOffset)
            }

            // Content
            TabView(selection: $selectedTab) {
                ForEach(0 ..< tabs.count, id: \.self) { index in
                    Text(tabs[index])
                        .tag(index)
                }
            }
            .tabViewStyle(.page(indexDisplayMode: .never))
            .onChange(of: selectedTab) { newValue in
                withAnimation(.spring()) {
                    tabOffset = UIScreen.main.bounds.width / CGFloat(tabs.count) * CGFloat(newValue)
                }
            }
        }
    }
}

#Preview {
    DynamicTabView()
}

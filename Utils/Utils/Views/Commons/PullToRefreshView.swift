//
//  PullToRefreshView.swift
//  Utils
//
//  Created by Jmy on 2023/08/06.
//

import SwiftUI

struct PullToRefreshView: View {
    private static let minRefreshTimeInterval = TimeInterval(0.2)
    private static let triggerHeight = CGFloat(1)
    private static let indicatorHeight = CGFloat(60)
    private static let fullHeight = triggerHeight + indicatorHeight

    let backgroundColor: Color
    let foregroundColor: Color
    let isEnabled: Bool
    let onRefresh: () -> Void

    @State private var isRefreshIndicatorVisible = false
    @State private var refreshStartTime: Date? = nil

    init(bg: Color = .white, fg: Color = .black, isEnabled: Bool = true, onRefresh: @escaping () -> Void) {
        backgroundColor = bg
        foregroundColor = fg
        self.isEnabled = isEnabled
        self.onRefresh = onRefresh
    }

    var body: some View {
        VStack(spacing: 0) {
            LazyVStack(spacing: 0) {
                Color.clear
                    .frame(height: Self.triggerHeight)
                    .onAppear {
                        if isEnabled {
                            withAnimation {
                                isRefreshIndicatorVisible = true
                            }
                            refreshStartTime = Date()
                        }
                    }
                    .onDisappear {
                        if isEnabled, isRefreshIndicatorVisible, let diff = refreshStartTime?.distance(to: Date()), diff > Self.minRefreshTimeInterval {
                            onRefresh()
                        }
                        withAnimation {
                            isRefreshIndicatorVisible = false
                        }
                        refreshStartTime = nil
                    }
            }
            .frame(height: Self.triggerHeight)

            indicator
                .frame(height: Self.indicatorHeight)
        }
        .background(backgroundColor)
        .ignoresSafeArea(edges: .all)
        .frame(height: Self.fullHeight)
        .padding(.top, -Self.fullHeight)
    }

    private var indicator: some View {
        ProgressView()
            .progressViewStyle(CircularProgressViewStyle(tint: foregroundColor))
            .scaleEffect(1, anchor: .center)
            .font(.title)
            .opacity(isRefreshIndicatorVisible ? 1 : 0)
    }
}

struct PullToRefreshView_Previews: PreviewProvider {
    static var previews: some View {
        PullToRefreshView(bg: .gray800, fg: .limeGreen) {
            print("PullToRefreshView")
        }
    }
}

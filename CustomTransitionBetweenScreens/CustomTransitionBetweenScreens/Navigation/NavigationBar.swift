//
//  NavigationBar.swift
//  CustomTransitionBetweenScreens
//
//  Created by Jmy on 2023/05/17.
//

import SwiftUI

struct NavigationBar: View {
    var title = ""
    @Binding var hasScrolled: Bool
    @State private var showSearch = false
    @State private var showAccount = false

    var body: some View {
        ZStack {
            Color.clear
                .background(.ultraThinMaterial)
                .blur(radius: 10)
                .opacity(hasScrolled ? 1 : 0)

            Text(title)
//                .animatableFont(size: hasScrolled ? 22 : 34, weight: .bold)
                .font(.largeTitle.weight(.bold))
                .frame(maxWidth: .infinity, alignment: .leading)
                .padding(.leading, 20)
                .padding(.top, 20)
                .offset(y: hasScrolled ? -4 : 0)

            HStack(spacing: 16) {
                Button {
                    showSearch = true
                } label: {
                    Image(systemName: "magnifyingglass")
                        .font(.body.weight(.bold))
                        .frame(width: 36, height: 36)
                        .foregroundColor(.secondary)
                        .background(.ultraThinMaterial, in: RoundedRectangle(cornerRadius: 14, style: .continuous))
                }
                .sheet(isPresented: $showSearch) {
                    SearchView()
                }

                Button {
                    showAccount = true
                } label: {
                    Image(systemName: "person.crop.circle")
                        .resizable()
                        .foregroundColor(.secondary)
                        .frame(width: 26, height: 26)
                        .cornerRadius(10)
                        .padding(8)
                        .background(.ultraThinMaterial, in: RoundedRectangle(cornerRadius: 18, style: .continuous))
                }
                .sheet(isPresented: $showAccount) {
                    AccountView()
                }
            }
            .frame(maxWidth: .infinity, alignment: .trailing)
            .padding(.trailing, 20)
            .padding(.top, 20)
        }
        .frame(height: 70)
        .frame(maxHeight: .infinity, alignment: .top)
    }
}

struct NavigationBar_Previews: PreviewProvider {
    static var previews: some View {
        NavigationBar(title: "Featured", hasScrolled: .constant(true))
    }
}

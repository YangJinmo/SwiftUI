//
//  TogglableScrollView.swift
//  Utils
//
//  Created by Jmy on 2023/08/21.
//

import SwiftUI

struct TogglableScrollView<Content>: View where Content: View {
    @Binding var canScroll: Bool
    var axis: Axis.Set = .vertical
    var showsIndicators: Bool = false
    var content: () -> Content

    var body: some View {
        if canScroll {
            ScrollView(axis, showsIndicators: showsIndicators, content: content)
        } else {
            content()
        }
    }
}

#Preview {
    TogglableScrollView_Previews_View()
}

struct TogglableScrollView_Previews_View: View {
    @State private var canScroll: Bool = false
    let allColors: [UIColor] = [.purple, .systemPink, .systemGreen, .systemBlue, .black, .cyan, .magenta, .orange, .systemYellow, .systemIndigo, .systemRed]
    @State private var colors: [UIColor] = [.white]

    var body: some View {
        VStack {
            Spacer()

            VStack {
                TogglableScrollView(canScroll: $canScroll) {
                    ForEach(colors.indices, id: \.self) { index in
                        Rectangle().fill().foregroundColor(Color(colors[index]))
                            .frame(height: 44)
                            .cornerRadius(8)
                    }
                }
                .fixedSize(horizontal: false, vertical: true)

                HStack {
                    Spacer()

                    Toggle(isOn: $canScroll) {
                        Text("Toggle Scroll")
                    }
                    .toggleStyle(SwitchToggleStyle(tint: .orange))
                }
                .padding(.top)
            }
            .textFieldStyle(RoundedBorderTextFieldStyle())
            .padding()
            .background(Rectangle().fill().foregroundColor(Color(UIColor.secondarySystemFill)).cornerRadius(8))

            HStack {
                Button {
                    addField()
                } label: {
                    Image(systemName: "plus")
                }
                .padding()
            }
        }
        .padding()
    }

    func addField() {
        colors.append(allColors.randomElement()!)
    }
}

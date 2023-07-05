//
//  MailView.swift
//  Gmail
//
//  Created by Jmy on 2023/07/04.
//

import SwiftUI

struct MailView: View {
    @Binding var hideBar: Bool
    var bottomEdge: CGFloat

    @State var offset: CGFloat = 0
    @State var lastOffset: CGFloat = 0

    var body: some View {
        ScrollView(.vertical, showsIndicators: false) {
            VStack(alignment: .leading, spacing: 20) {
                Text("PRIMARY")
                    .font(.callout.bold())
                    .foregroundColor(.gray)
                    .padding(.leading, 5)

                ForEach(allMessages) { message in
                    CardView(message: message)
                }
            }
            .overlay(
                GeometryReader { proxy -> Color in
                    let minY = proxy.frame(in: .named("SCROLL")).minY
                    let durationOffset: CGFloat = 35

                    DispatchQueue.main.async {
                        if minY < offset {
                            if offset < 0 && -minY > (lastOffset + durationOffset) {
                                withAnimation(.easeOut.speed(1.5)) {
                                    hideBar = true
                                }

                                lastOffset = -offset
                            }
                        }
                        if minY > offset && -minY < (lastOffset - durationOffset) {
                            withAnimation(.easeOut.speed(1.5)) {
                                hideBar = false
                            }

                            lastOffset = -offset
                        }
                        self.offset = minY
                    }

                    return Color.clear
                }
            )
            .padding()
            .padding(.bottom, 15 + 35 + bottomEdge)
        }
        .coordinateSpace(name: "SCROLL")
    }

    @ViewBuilder
    func CardView(message: Message) -> some View {
        HStack(spacing: 15) {
            Text(String(message.userName.first ?? "i"))
                .font(.title2)
                .fontWeight(.bold)
                .frame(width: 55, height: 55)
                .background(message.tintColor, in: Circle())

            VStack(alignment: .leading, spacing: 8) {
                Text(message.userName)
                    .fontWeight(.bold)

                Text(message.message)
                    .font(.callout)
                    .foregroundColor(.gray)
            }
            .frame(maxWidth: .infinity, alignment: .leading)
        }
    }
}

struct MailView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}

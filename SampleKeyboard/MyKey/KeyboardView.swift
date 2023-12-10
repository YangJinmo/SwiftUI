//
//  KeyboardView.swift
//  MyKey
//
//  Created by Jmy on 2023/12/09.
//

import SwiftUI

struct KeyboardView: View {
    var body: some View {
        VStack {
            Button {
                NotificationCenter.default.post(name: NSNotification.Name("addKey"), object: "Hi!")
            } label: {
                Text("Hi!")
                    .frame(maxWidth: .infinity, minHeight: 40)
            }
            .buttonStyle(.bordered)
            
            Button {
                NotificationCenter.default.post(name: NSNotification.Name("addKey"), object: "My name is zzimss")
            } label: {
                Text("My name is zzimss")
                    .frame(maxWidth: .infinity, minHeight: 40)
            }
            .buttonStyle(.bordered)
        }
        .padding()
    }
}

struct KeyboardView_Previews: PreviewProvider {
    static var previews: some View {
        KeyboardView()
    }
}

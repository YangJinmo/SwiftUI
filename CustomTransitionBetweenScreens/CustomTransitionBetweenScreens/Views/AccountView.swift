//
//  AccountView.swift
//  CustomTransitionBetweenScreens
//
//  Created by Jmy on 2023/05/20.
//

import SwiftUI

struct AccountView: View {
    @State private var isDeleted = false
    @State private var isPinned = false
    @Environment(\.presentationMode) var presentationMode
    
    var body: some View {
        NavigationView {
            List {
                profile
                
//                menu
//
//                links
            }
            .listStyle(.insetGrouped)
            .navigationTitle("Account")
            .navigationBarItems(trailing:
                Button {
                    presentationMode.wrappedValue.dismiss()
                } label: {
                    Text("Done").bold()
                }
            )
        }
    }
    
    var profile: some View {
        VStack(spacing: 8) {
            Image(systemName: "person.crop.circle.fill.badge.checkmark")
                .symbolVariant(.circle.fill)
                .font(.system(size: 32))
                .symbolRenderingMode(.palette)
        }
    }
}

struct AccountView_Previews: PreviewProvider {
    static var previews: some View {
        AccountView()
    }
}

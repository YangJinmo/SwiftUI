//
//  UITestingBootcampView.swift
//  Utils
//
//  Created by Jmy on 5/7/24.
//

import SwiftUI

class UITestingBootcampViewModel: ObservableObject {
    let placeholderText: String = "Add your name..."
    @Published var textFieldText: String = ""
}

struct UITestingBootcampView: View {
    @StateObject private var vm = UITestingBootcampViewModel()
    var body: some View {
        ZStack {
            LinearGradient(
                gradient: Gradient(colors: [Color.blue, Color.black]),
                startPoint: .topLeading,
                endPoint: .bottomTrailing
            )
            .ignoresSafeArea()

            VStack {
                TextField(vm.placeholderText, text: $vm.textFieldText)
                    .font(.headline)
                    .padding()
                    .background(Color.white)
                    .cornerRadius(10)
                
                Button(action: {
                    
                }, label: {
                    Text("Sign Up")
                        .font(.headline)
                        .padding()
                        .frame(maxWidth: .infinity)
                        .background(Color.white)
                        .cornerRadius(10)
                    
                })
            }
            .padding()
        }
    }
}

#Preview {
    UITestingBootcampView()
}

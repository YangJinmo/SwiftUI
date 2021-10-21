//
//  ContentView.swift
//  SwiftUI_Example
//
//  Created by Jmy on 2021/10/21.
//

import SwiftUI

struct ContentView: View {
    var body: some View {
        VStack {
            Text("Hello, SwiftUI!")
                .font(.largeTitle)
                .foregroundColor(Color.blue)
                .padding()
                .background(Color.yellow)
            Text("Have a nice day :]")
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}

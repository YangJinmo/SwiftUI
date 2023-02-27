//
//  Mastering SwiftUI
//  Copyright (c) KxCoding <help@kxcoding.com>
//
//  Permission is hereby granted, free of charge, to any person obtaining a copy
//  of this software and associated documentation files (the "Software"), to deal
//  in the Software without restriction, including without limitation the rights
//  to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
//  copies of the Software, and to permit persons to whom the Software is
//  furnished to do so, subject to the following conditions:
//
//  The above copyright notice and this permission notice shall be included in
//  all copies or substantial portions of the Software.
//
//  THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
//  IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
//  FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
//  AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
//  LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
//  OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN
//  THE SOFTWARE.
//

import SwiftUI

struct View_TextField: View {
    private enum Field: Hashable {
        case name, password
    }

    @State private var name: String = ""
    @State private var password: String = ""

    @FocusState private var focusField: Field?

    var body: some View {
        VStack {
            Text("TextField")
                .font(.largeTitle)

            HStack {
                Text("Name: \(name)")
                    .font(.title)
                    .foregroundColor(.secondary)
                    .padding()
                Spacer()
            }

//      TextField("Input Somthing", text: $name, onEditingChanged: {
//        print($0)
//      }, onCommit: {
//        print("commit")
//      })

            TextField("Input Name", text: $name)
//                .padding()
                .textFieldStyle(RoundedBorderTextFieldStyle())
                .font(.title)
                .submitLabel(.next)
                .focused($focusField, equals: .name)
                // .keyboardType(.numberPad)
                // .textContentType(.username)
                // .autocapitalization(.none)
                .disableAutocorrection(true)
            TextField("Input Name", text: $name)
//                .padding()
                .textFieldStyle(RoundedBorderTextFieldStyle())
                .font(.title)
                .submitLabel(.next)
                .focused($focusField, equals: .name)
                // .keyboardType(.numberPad)
                // .textContentType(.username)
                // .autocapitalization(.none)
                .disableAutocorrection(true)
            TextField("Input Name", text: $name)
//                .padding()
                .textFieldStyle(RoundedBorderTextFieldStyle())
                .font(.title)
                .submitLabel(.next)
                .focused($focusField, equals: .name)
                // .keyboardType(.numberPad)
                // .textContentType(.username)
                // .autocapitalization(.none)
                .disableAutocorrection(true)

            TextField("Input Name", text: $name)
//                .padding()
                .textFieldStyle(RoundedBorderTextFieldStyle())
                .font(.title)
                .submitLabel(.next)
                .focused($focusField, equals: .name)
                // .keyboardType(.numberPad)
                // .textContentType(.username)
                // .autocapitalization(.none)
                .disableAutocorrection(true)
                .onSubmit {
                    focusField = .password
                }

            SecureField("Input Password", text: $password)
//                .padding()
                .textFieldStyle(RoundedBorderTextFieldStyle())
                .font(.title)
                .submitLabel(.done)
                .focused($focusField, equals: .password)
                .onSubmit {
                    focusField = nil
                    handleLogin()
                }

            Spacer()

            Button("Login") {
                if name.isEmpty {
                    focusField = .name
                } else if password.isEmpty {
                    focusField = .password
                } else {
                    focusField = nil
                    handleLogin()
                }
            }
            .padding()
            .frame(maxWidth: .infinity)
            .background(Color.blue)
            .foregroundColor(.white)
//            .buttonStyle(.borderedProminent)
            .cornerRadius(8)

//            Button {
//                if name.isEmpty {
//                    focusField = .name
//                } else if password.isEmpty {
//                    focusField = .password
//                } else {
//                    focusField = nil
//                    // handleLogin()
//                }
//            } label: {
//                Text("Login 2")
//                    .frame(maxWidth: .infinity)
//                    .padding()
//            }
//            .frame(maxWidth: .infinity)
//            .buttonStyle(.borderedProminent)
//            .cornerRadius(8)

            // 키보드가 표시되지 않으면 Cmd + K
        }
        .padding()
        .onAppear {
            focusField = .name
        }
    }

    private func handleLogin() {
        debugPrint("handleLogin")
    }
}

struct View_TextField_Previews: PreviewProvider {
    static var previews: some View {
        View_TextField()
    }
}

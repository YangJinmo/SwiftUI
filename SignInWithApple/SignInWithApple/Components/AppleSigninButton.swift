//
//  AppleSigninButton.swift
//  SignInWithApple
//
//  Created by Jmy on 2023/04/29.
//

import AuthenticationServices
import SwiftUI

struct AppleSigninButton: View {
    var body: some View {
        SignInWithAppleButton(
            .signIn,
            onRequest: { request in
                request.requestedScopes = [.fullName, .email]
            },
            onCompletion: { result in
                switch result {
                case let .success(authorization):
                    print("Apple Login Successful")

                    switch authorization.credential {
                    case let appleIDCredential as ASAuthorizationAppleIDCredential:

                        let userID = appleIDCredential.user
                        let fullName = appleIDCredential.fullName
                        let name = (fullName?.familyName ?? "") + (fullName?.givenName ?? "")
                        let email = appleIDCredential.email
                        let identityToken = String(data: appleIDCredential.identityToken!, encoding: .utf8)
                        let authorizationCode = String(data: appleIDCredential.authorizationCode!, encoding: .utf8)

                        print("userID: \(userID)")
                        print("fullName: \(fullName ?? PersonNameComponents())")
                        print("name: \(name)")
                        print("email: \(email ?? "")")
                        print("identityToken: \(identityToken ?? "")")
                        print("authorizationCode: \(authorizationCode ?? "")")

                    case let passwordCredential as ASPasswordCredential:

                        // Sign in using an existing iCloud Keychain credential.
                        let username = passwordCredential.user
                        let password = passwordCredential.password
                        print("username: \(username)")
                        print("password: \(password)")

                    default:
                        break
                    }
                case let .failure(error):
                    print("Error: \(error.localizedDescription)")
                }
            }
        )
        .signInWithAppleButtonStyle(.whiteOutline)
        .frame(width: 280, height: 60)
        .padding(6)
    }
}

struct AppleSigninButton_Previews: PreviewProvider {
    static var previews: some View {
        AppleSigninButton()
    }
}

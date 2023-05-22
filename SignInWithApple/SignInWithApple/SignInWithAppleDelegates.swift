//
//  SignInWithAppleDelegates.swift
//  SignInWithApple
//
//  Created by Jmy on 2023/05/22.
//

import AuthenticationServices
import Contacts
import UIKit

class SignInWithAppleDelegates: NSObject {
    private let signInSucceeded: (Bool) -> Void

    init(onSignedIn: @escaping (Bool) -> Void) {
        signInSucceeded = onSignedIn
    }
}

extension SignInWithAppleDelegates: ASAuthorizationControllerDelegate {
    private func registerNewAccount(credential: ASAuthorizationAppleIDCredential) {
        // 1
        let userData = UserData(email: credential.email!,
                                name: credential.fullName!,
                                identifier: credential.user)

        // 2
        let keychain = UserDataKeychain()
        do {
            try keychain.store(userData)
        } catch {
            signInSucceeded(false)
        }

        // 3
        do {
            let success = try WebApi.Register(user: userData,
                                              identityToken: credential.identityToken,
                                              authorizationCode: credential.authorizationCode)
            signInSucceeded(success)
        } catch {
            signInSucceeded(false)
        }
    }

    private func signInWithExistingAccount(credential: ASAuthorizationAppleIDCredential) {
        // You *should* have a fully registered account here.  If you get back an error from your server
        // that the account doesn't exist, you can look in the keychain for the credentials and rerun setup

        // if (WebAPI.Login(credential.user, credential.identityToken, credential.authorizationCode)) {
        //   ...
        // }
        signInSucceeded(true)
    }

    private func signInWithUserAndPassword(credential: ASPasswordCredential) {
        // You *should* have a fully registered account here.  If you get back an error from your server
        // that the account doesn't exist, you can look in the keychain for the credentials and rerun setup

        // if (WebAPI.Login(credential.user, credential.password)) {
        //   ...
        // }
        signInSucceeded(true)
    }

    func authorizationController(controller: ASAuthorizationController, didCompleteWithAuthorization authorization: ASAuthorization) {
        switch authorization.credential {
        case let appleIdCredential as ASAuthorizationAppleIDCredential:
            if let _ = appleIdCredential.email, let _ = appleIdCredential.fullName {
                registerNewAccount(credential: appleIdCredential)
            } else {
                signInWithExistingAccount(credential: appleIdCredential)
            }

            break

        case let passwordCredential as ASPasswordCredential:
            signInWithUserAndPassword(credential: passwordCredential)

            break

        default:
            break
        }
    }

    func authorizationController(controller: ASAuthorizationController, didCompleteWithError error: Error) {
        // Handle error.
    }
}

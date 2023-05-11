//
//  CustomSignInWithAppleButton.swift
//  SignInWithApple
//
//  Created by Jmy on 2023/05/08.
//

import AuthenticationServices
import SwiftUI

struct CustomSignInWithAppleButton: UIViewRepresentable {
    func makeUIView(context: Context) -> UIButton {
        var titleAttr = AttributedString("Apple로 계속하기")
        titleAttr.font = .systemFont(ofSize: 20.0, weight: .bold)

        let imageConfiguration = UIImage.SymbolConfiguration(pointSize: 14.0)

        var buttonConfiguration = UIButton.Configuration.filled()
        buttonConfiguration.attributedTitle = titleAttr
        buttonConfiguration.image = UIImage(systemName: "apple.logo", withConfiguration: imageConfiguration)
        buttonConfiguration.imagePadding = 10
        buttonConfiguration.imagePlacement = .leading
        buttonConfiguration.baseBackgroundColor = .white
        buttonConfiguration.baseForegroundColor = .black
        buttonConfiguration.background.cornerRadius = 8

        let didTapButton = UIAction { _ in
            context.coordinator.handleAuthorizationAppleIDButtonPress()
        }

        let button = UIButton(configuration: buttonConfiguration, primaryAction: didTapButton)
        button.layer.borderWidth = 0.5
        button.layer.borderColor = UIColor.black.cgColor
        button.layer.cornerRadius = 8
        return button
    }

    func updateUIView(_ uiView: UIButton, context: Context) {
        // Nothing to update
    }

    func makeCoordinator() -> Coordinator {
        return Coordinator()
    }

    class Coordinator: NSObject {
        func handleAuthorizationAppleIDButtonPress() {
            let provider = ASAuthorizationAppleIDProvider()
            let request = provider.createRequest()
            request.requestedScopes = [.fullName, .email]

            performSignIn(using: [request])
        }

        func performExistingAccountSetupFlows() {
            let requests = [
                ASAuthorizationAppleIDProvider().createRequest(),
                ASAuthorizationPasswordProvider().createRequest(),
            ]

            performSignIn(using: requests)
        }

        private func performSignIn(using requests: [ASAuthorizationRequest]) {
            let controller = ASAuthorizationController(authorizationRequests: requests)
            controller.delegate = self
            controller.presentationContextProvider = self as? ASAuthorizationControllerPresentationContextProviding
            controller.performRequests()
        }
    }
}

extension CustomSignInWithAppleButton.Coordinator: ASAuthorizationControllerDelegate {
    func authorizationController(controller: ASAuthorizationController, didCompleteWithAuthorization authorization: ASAuthorization) {
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

            if let _ = appleIDCredential.email, let _ = appleIDCredential.fullName {
                registerNewAccount(credential: appleIDCredential)
            } else {
                signInWithExistingAccount(credential: appleIDCredential)
            }

        case let passwordCredential as ASPasswordCredential:

            // Sign in using an existing iCloud Keychain credential.
            let username = passwordCredential.user
            let password = passwordCredential.password
            print("username: \(username)")
            print("password: \(password)")

        default:
            break
        }
    }

    private func registerNewAccount(credential: ASAuthorizationAppleIDCredential) {
        // 1. Save the desired details and the Apple-provided user in a struct.
        let userData = UserData(
            email: credential.email!,
            name: credential.fullName!,
            identifier: credential.user
        )

        // 2. Store the details into the iCloud keychain for later use.
        let keychain = UserDataKeychain()

        do {
            try keychain.store(userData)
        } catch {
            // signInSucceeded(false)
        }

        // 3. Make a call to your service and signify to the caller whether registration succeeded or not.
        do {
            let success = try WebApi.Register(
                user: userData,
                identityToken: credential.identityToken,
                authorizationCode: credential.authorizationCode
            )
            // signInSucceeded(success)
        } catch {
            // signInSucceeded(false)
        }
    }

    private func signInWithExistingAccount(credential: ASAuthorizationAppleIDCredential) {
        // You *should* have a fully registered account here.  If you get back an error from your server
        // that the account doesn't exist, you can look in the keychain for the credentials and rerun setup

        // if (WebAPI.Login(credential.user, credential.identityToken, credential.authorizationCode)) {
        //   ...
        // }
        // signInSucceeded(true)
    }

    private func signInWithUserAndPassword(credential: ASPasswordCredential) {
        // You *should* have a fully registered account here.  If you get back an error from your server
        // that the account doesn't exist, you can look in the keychain for the credentials and rerun setup

        // if (WebAPI.Login(credential.user, credential.password)) {
        //   ...
        // }
        // signInSucceeded(true)
    }

    func authorizationController(controller: ASAuthorizationController, didCompleteWithError error: Error) {
        print("Apple Login Error: \(error.localizedDescription)")
    }
}

struct WebApi {
    static func Register(user: UserData, identityToken: Data?, authorizationCode: Data?) throws -> Bool {
        return true
    }
}

/// Represents the details about the user which were provided during initial registration.
struct UserData: Codable {
    /// The email address to use for user communications.  Remember it might be a relay!
    let email: String

    /// The components which make up the user's name.  See `displayName(style:)`
    let name: PersonNameComponents

    /// The team scoped identifier Apple provided to represent this user.
    let identifier: String

    /// Returns the localized name for the person
    /// - Parameter style: The `PersonNameComponentsFormatter.Style` to use for the display.
    func displayName(style: PersonNameComponentsFormatter.Style = .default) -> String {
        PersonNameComponentsFormatter.localizedString(from: name, style: style)
    }
}

struct UserDataKeychain: Keychain {
    // Make sure the account name doesn't match the bundle identifier!
    var account = "com.zzimss.SignInWithApple"
    var service = "userIdentifier"

    typealias DataType = UserData
}

enum KeychainError: Error {
    case secCallFailed(OSStatus)
    case notFound
    case badData
    case archiveFailure(Error)
}

protocol Keychain {
    associatedtype DataType: Codable

    var account: String { get set }
    var service: String { get set }

    func remove() throws
    func retrieve() throws -> DataType
    func store(_ data: DataType) throws
}

extension Keychain {
    func remove() throws {
        let status = SecItemDelete(keychainQuery() as CFDictionary)
        guard status == noErr || status == errSecItemNotFound else {
            throw KeychainError.secCallFailed(status)
        }
    }

    func retrieve() throws -> DataType {
        var query = keychainQuery()
        query[kSecMatchLimit as String] = kSecMatchLimitOne
        query[kSecReturnAttributes as String] = kCFBooleanTrue
        query[kSecReturnData as String] = kCFBooleanTrue

        var result: AnyObject?
        let status = withUnsafeMutablePointer(to: &result) {
            SecItemCopyMatching(query as CFDictionary, UnsafeMutablePointer($0))
        }

        guard status != errSecItemNotFound else { throw KeychainError.notFound }
        guard status == noErr else { throw KeychainError.secCallFailed(status) }

        do {
            guard
                let dict = result as? [String: AnyObject],
                let data = dict[kSecAttrGeneric as String] as? Data,
                let userData = try NSKeyedUnarchiver.unarchiveTopLevelObjectWithData(data) as? DataType
            else {
                throw KeychainError.badData
            }

            return userData
        } catch {
            throw KeychainError.archiveFailure(error)
        }
    }

    func store(_ data: DataType) throws {
        var query = keychainQuery()

        let archived: AnyObject
        do {
            archived = try NSKeyedArchiver.archivedData(withRootObject: data, requiringSecureCoding: true) as AnyObject
        } catch {
            throw KeychainError.archiveFailure(error)
        }

        let status: OSStatus
        do {
            // If doesn't already exist, this will throw a KeychainError.notFound,
            // causing the catch block to add it.
            _ = try retrieve()

            let updates = [
                String(kSecAttrGeneric): archived,
            ]

            status = SecItemUpdate(query as CFDictionary, updates as CFDictionary)
        } catch KeychainError.notFound {
            query[kSecAttrGeneric as String] = archived
            status = SecItemAdd(query as CFDictionary, nil)
        }

        guard status == noErr else {
            throw KeychainError.secCallFailed(status)
        }
    }

    private func keychainQuery() -> [String: AnyObject] {
        var query: [String: AnyObject] = [:]
        query[kSecClass as String] = kSecClassGenericPassword
        query[kSecAttrService as String] = service as AnyObject
        query[kSecAttrAccount as String] = account as AnyObject

        return query
    }
}

// Implementing User Authentication with Sign in with Apple
// https://developer.apple.com/documentation/authenticationservices/implementing_user_authentication_with_sign_in_with_apple

// Sign in with Apple Using SwiftUI
// https://www.kodeco.com/4875322-sign-in-with-apple-using-swiftui

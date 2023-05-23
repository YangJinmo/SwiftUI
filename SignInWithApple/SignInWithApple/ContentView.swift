//
//  ContentView.swift
//  SignInWithApple
//
//  Created by Jmy on 2023/04/29.
//

import AuthenticationServices
import PopupView
import SwiftUI

struct ContentView: View {
    @State private var appleSignInDelegates: SignInWithAppleDelegates! = nil
    @State private var alertMessage: AlertMessage?
    @State private var isPresented: Bool = false

    private let userID = ""

    var body: some View {
        VStack {
            AppleSigninButton()

            CustomSignInWithAppleButtonWithAction()
                .frame(height: 48)
                .padding(.horizontal, 20)

            CustomSignInWithAppleButton()
                .frame(height: 48)
                .padding(.horizontal, 20)
                .onTapGesture(perform: showAppleLogin)

            Button {
                getCredentialState(forUserID: userID)
            } label: {
                Text("Credential State")
                    .font(.headline)
            }
            .padding(8)
            .border(.blue)
        }
        .onReceive(NotificationCenter.default.publisher(for: ASAuthorizationAppleIDProvider.credentialRevokedNotification)) { notification in
            // A notification that indicates the user’s credentials have been revoked and they should be signed out.
            // 사용자의 자격 증명이 취소되었으며 로그아웃해야 함을 나타내는 알림입니다.
            // Perform any necessary actions when credentials are revoked
            // 자격 증명이 취소되면 필요한 조치를 수행합니다.
            print("Credentials revoked!: \(notification)")
            self.alertMessage = AlertMessage(title: "credentialRevokedNotification", message: "Credentials revoked")
        }
        .alert(item: $alertMessage) { alertMessage in
            Alert(
                title: Text(alertMessage.title),
                message: Text(alertMessage.message),
                dismissButton: .default(Text("OK"))
            )
        }
        .popup(isPresented: $isPresented) {
            ToastBottomFirst(isShowing: $isPresented)
        } customize: {
            $0
                .type(.toast)
                .position(.bottom)
                .closeOnTap(false)
                .backgroundColor(.black.opacity(0.4))
        }
    }

    private func showAppleLogin() {
        let request = ASAuthorizationAppleIDProvider().createRequest()
        request.requestedScopes = [.fullName, .email]

        performSignIn(using: [request])
    }

    private func performSignIn(using requests: [ASAuthorizationRequest]) {
        appleSignInDelegates = SignInWithAppleDelegates { success in
            if success {
                // update UI
                print("update UI")
                isPresented = true
            } else {
                // show the user an error
                print("show the user an error")
            }
        }

        let controller = ASAuthorizationController(authorizationRequests: requests)
        controller.delegate = appleSignInDelegates
        controller.presentationContextProvider = appleSignInDelegates as? any ASAuthorizationControllerPresentationContextProviding

        controller.performRequests()
    }

    private func getCredentialState(forUserID userID: String) {
        let appleIDProvider = ASAuthorizationAppleIDProvider()
        appleIDProvider.getCredentialState(forUserID: userID) { credentialState, error in
            if let error = error {
                self.alertMessage = AlertMessage(title: "Error", message: error.localizedDescription)
            }

            switch credentialState {
            case .authorized:
                // The given user’s authorization has been revoked and they should be signed out.
                print("지정된 사용자의 승인이 취소되었으며 로그아웃해야 합니다.")
                self.alertMessage = AlertMessage(title: "Credential State: authorized", message: "지정된 사용자의 승인이 취소되었으며 로그아웃해야 합니다.")

            case .revoked:
                // The user is authorized.
                print("사용자에게 권한이 부여되었습니다.")
                self.alertMessage = AlertMessage(title: "Credential State: revoked", message: "사용자에게 권한이 부여되었습니다.")

            case .notFound:
                // The user hasn’t established a relationship with Sign in with Apple.
                print("사용자가 Apple로 로그인과 관계를 설정하지 않았습니다.")
                self.alertMessage = AlertMessage(title: "Credential State: notFound", message: "사용자가 Apple로 로그인과 관계를 설정하지 않았습니다.")

            case .transferred:
                // The app has been transferred to a different team, and you need to migrate the user’s identifier.
                print("앱이 다른 팀으로 이전되었으며 사용자의 식별자를 이전해야 합니다.")
                self.alertMessage = AlertMessage(title: "Credential State: transferred", message: "앱이 다른 팀으로 이전되었으며 사용자의 식별자를 이전해야 합니다.")

            default:
                self.alertMessage = AlertMessage(title: "Credential State: unknown", message: "unknown")
            }
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}

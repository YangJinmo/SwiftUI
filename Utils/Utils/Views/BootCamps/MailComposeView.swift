//
//  MailComposeView.swift
//  Utils
//
//  Created by Jmy on 9/23/24.
//

import MessageUI
import SwiftUI

struct MailComposeView: View {
    @State private var isShowingMailView = false
    @State private var alertItem: AlertItem?

    private let email = "didwlsah9@gmail.com"

    var body: some View {
        VStack {
            Button(action: {
                if MFMailComposeViewController.canSendMail() {
                    self.isShowingMailView = true
                } else {
                    UIPasteboard.general.string = self.email
                    self.alertItem = AlertItem(
                        title: "메일 앱을 사용할 수 없습니다",
                        message: "메일 주소가 복사되었습니다."
                    )
                }
            }) {
                Text("sendEmail")
                    .padding()
                    .background(Color.blue)
                    .foregroundColor(.white)
                    .cornerRadius(10)
            }
        }
        .navigationBarTitle("메일 작성")
        .sheet(isPresented: $isShowingMailView) {
            MailView(isShowing: self.$isShowingMailView, result: self.handleMailResult)
        }
        .alert(item: $alertItem) { alertItem in
            Alert(title: Text(alertItem.title), message: Text(alertItem.message), dismissButton: .default(Text("확인")))
        }
    }

    private func handleMailResult(_ result: Result<MFMailComposeResult, Error>) {
        isShowingMailView = false
        switch result {
        case let .success(result):
            switch result {
            case .cancelled:
                alertItem = AlertItem(title: "취소됨", message: "메일 작성을 취소하였습니다.")
            case .saved:
                alertItem = AlertItem(title: "저장됨", message: "메일을 저장하였습니다.")
            case .sent:
                alertItem = AlertItem(title: "전송 완료", message: "메일을 정상적으로 발송하였습니다.")
            case .failed:
                alertItem = AlertItem(title: "전송 실패", message: "메일 발송을 실패하였습니다.")
            @unknown default:
                break
            }
        case let .failure(error):
            alertItem = AlertItem(title: "오류", message: error.localizedDescription)
        }
    }
}

struct MailView: UIViewControllerRepresentable {
    @Binding var isShowing: Bool
    var result: (Result<MFMailComposeResult, Error>) -> Void

    func makeUIViewController(context: Context) -> MFMailComposeViewController {
        let vc = MFMailComposeViewController()
        vc.mailComposeDelegate = context.coordinator
        vc.setToRecipients(["didwlsah9@gmail.com"])
        vc.setSubject("[이용 문의 및 제안]")

        let nickname = "getNickname" // 실제 닉네임을 가져오는 로직으로 대체해야 합니다.
        let messageBody = """
        자세한 정보를 보내주시면 좀 더 빠른 해결이 가능해요!

        닉네임: \(nickname)
        앱버전: \(Bundle.main.infoDictionary?["CFBundleShortVersionString"] as? String ?? "Unknown")


        ▶ 내용:




        """
        vc.setMessageBody(messageBody, isHTML: false)
        return vc
    }

    func updateUIViewController(_ uiViewController: MFMailComposeViewController, context: Context) {}

    func makeCoordinator() -> Coordinator {
        Coordinator(isShowing: $isShowing, result: result)
    }

    class Coordinator: NSObject, MFMailComposeViewControllerDelegate {
        @Binding var isShowing: Bool
        var result: (Result<MFMailComposeResult, Error>) -> Void

        init(isShowing: Binding<Bool>, result: @escaping (Result<MFMailComposeResult, Error>) -> Void) {
            _isShowing = isShowing
            self.result = result
        }

        func mailComposeController(_ controller: MFMailComposeViewController, didFinishWith result: MFMailComposeResult, error: Error?) {
            defer {
                isShowing = false
            }
            if let error = error {
                self.result(.failure(error))
            } else {
                self.result(.success(result))
            }
        }
    }
}

struct AlertItem: Identifiable {
    let id = UUID()
    let title: String
    let message: String
}

#Preview {
    MailComposeView()
}

//
//  ToastBottomTermsAgreeView.swift
//  SignInWithApple
//
//  Created by Jmy on 2023/05/24.
//

import SwiftUI

struct ToastBottomTermsAgreeView: View {
    @Binding var terms: [TermsDTO]
    var onContinue: (() -> Void)?

    @State private var isOn: Bool = false
    @State private var isActive: Bool = false

    var body: some View {
        VStack(alignment: .leading, spacing: 16) {
            titleView

            termsView

            continueView
        }
        .padding(.init(top: 20, leading: 20, bottom: 0, trailing: 20))
        .padding(.bottom, .toastBottom)
        .frame(maxWidth: .infinity)
        .background(Color.gray700.cornerRadius(20))
    }

    var titleView: some View {
        Text("약관에 동의해주세요")
            .foregroundColor(.gray100)
            .font(.headline)
    }

    var termsView: some View {
        VStack(spacing: 0) {
            Toggle("모두 동의", isOn: $isOn)
                .onChange(of: isOn) { _ in
                    checkAll()
                }
                .toggleStyle(.checklist)

            ForEach($terms) { $term in
                HStack {
                    Toggle("\(term.isRequired ? "(필수)" : "(선택)") \(term.name)", isOn: $term.isOn)
                        .onChange(of: term.isOn) { _ in
                            checkOn()
                            checkActive()
                        }
                        .toggleStyle(.checklist)

                    Button {
                    } label: {
                        Text("보기")
                            .font(.footnote)
                            .foregroundColor(.gray400)
                            .frame(maxWidth: 56, maxHeight: 44, alignment: .trailing)
                    }
                }
            }
        }
    }

    var continueView: some View {
        HStack(spacing: 16) {
            Button {
                if isActive {
                    onContinue?()
                }
            } label: {
                Text("계속하기")
                    .buttonStyle(.plain)
                    .font(.subheadline.bold())
                    .foregroundColor(isActive ? Color.gray800 : Color.gray300)
                    .frame(maxWidth: .infinity)
                    .padding(.vertical, 16)
                    .padding(.horizontal, 20)
                    .background(isActive ? Color.limeGreen : Color.gray500)
                    .cornerRadius(8)
            }
        }
    }

    private func checkAll() {
        if isOn {
            for index in terms.indices {
                terms[index].isOn = isOn
            }
        }
    }

    private func checkOn() {
        isOn = terms.allSatisfy { $0.isOn }
    }

    private func checkActive() {
        isActive = terms.filter { $0.isRequired }.allSatisfy { $0.isOn }
    }
}

struct ToastBottomTermsAgreeView_Previews: PreviewProvider {
    static var previews: some View {
        ZStack {
            Rectangle()
                .ignoresSafeArea()
            VStack {
                ToastBottomTermsAgreeView(
                    terms: .constant(
                        [
                            TermsDTO(id: 0, type: "OA", name: "약관 제목", content: "약관 내용", isRequired: true, isOn: false),
                            TermsDTO(id: 0, type: "OA", name: "약관 제목", content: "약관 내용", isRequired: true, isOn: false),
                            TermsDTO(id: 0, type: "OA", name: "약관 제목", content: "약관 내용", isRequired: true, isOn: false),
                        ]
                    ),
                    onContinue: {}
                )
            }
        }
        .previewDevice("iPhone 14 Pro")
    }
}

struct CheckboxToggleStyle: ToggleStyle {
    @Environment(\.isEnabled) var isEnabled
    let style: Style

    func makeBody(configuration: Configuration) -> some View {
        Button {
            configuration.isOn.toggle()
        } label: {
            HStack {
                Image(systemName: "checkmark.\(style.sfSymbolName).fill")
                    .imageScale(.large)

                configuration.label
                    .font(.callout)
                    .tint(.gray300)
            }
            .frame(maxWidth: .infinity, maxHeight: 44, alignment: .leading)
        }
        .tint(configuration.isOn ? .limeGreen : .gray500)
        .disabled(!isEnabled)
    }

    enum Style {
        case square, circle

        var sfSymbolName: String {
            switch self {
            case .square:
                return "square"
            case .circle:
                return "circle"
            }
        }
    }
}

extension ToggleStyle where Self == CheckboxToggleStyle {
    static var checklist: CheckboxToggleStyle { .init(style: .circle) }
}

import UIKit.UIApplication

extension UIApplication {
    static var sharedKeyWindow: UIWindow? {
        UIApplication.shared.connectedScenes
            .first(where: { $0 is UIWindowScene })
            .flatMap({ $0 as? UIWindowScene })?.windows
            .first(where: \.isKeyWindow)
    }
}

import UIKit.UIGeometry

extension UIEdgeInsets {
    static var safeAreaInsets: UIEdgeInsets {
        return UIApplication.sharedKeyWindow?.safeAreaInsets ?? UIEdgeInsets()
    }
}

import CoreFoundation
import UIKit.UIGeometry

extension CGFloat {
    static var top: CGFloat {
        return UIEdgeInsets.safeAreaInsets.top
    }

    static var bottom: CGFloat {
        return UIEdgeInsets.safeAreaInsets.bottom
    }

    static var toastBottom: CGFloat {
        return bottom > 0 ? bottom : 20
    }
}

struct TermsDTO: Codable, Identifiable {
    enum CodingKeys: String, CodingKey {
        case id
        case type
        case name
        case content
        case isRequired
    }

    let id: Int
    let type: String
    let name: String
    let content: String
    let isRequired: Bool

    var isOn = false
}

import SwiftUI

extension Color {
    static let limeGreen = Color.rgba(4, 219, 108, 1)
    static let emeraldGreen = Color.rgba(5, 197, 147, 1)
    static let lightYellow = Color.rgba(252, 255, 125, 1)
    static let red = Color.rgba(223, 29, 29, 1)

    static let gray800 = Color.rgba(23, 27, 28, 1)
    static let gray700 = Color.rgba(46, 54, 58, 1)
    static let gray600 = Color.rgba(65, 71, 76, 1)
    static let gray500 = Color.rgba(90, 97, 102, 1)
    static let gray400 = Color.rgba(153, 159, 164, 1)
    static let gray300 = Color.rgba(197, 200, 206, 1)
    static let gray200 = Color.rgba(247, 248, 249, 1)
    static let gray100 = Color.rgba(253, 253, 253, 1)
}

extension Color {
    init(hex: UInt, opacity: Double = 1) {
        let color = (
            red: (hex >> 16) & 0xFF,
            green: (hex >> 08) & 0xFF,
            blue: (hex >> 00) & 0xFF
        )

        self.init(
            .sRGB,
            red: Double(color.red) / 255,
            green: Double(color.green) / 255,
            blue: Double(color.blue) / 255,
            opacity: opacity
        )
    }

    static func rgba(_ red: CGFloat, _ green: CGFloat, _ blue: CGFloat, _ opacity: CGFloat) -> Color {
        .init(red: red / 255, green: green / 255, blue: blue / 255, opacity: opacity)
    }

    static func random() -> Color {
        .init(red: .random(in: 0 ... 1), green: .random(in: 0 ... 1), blue: .random(in: 0 ... 1))
    }
}

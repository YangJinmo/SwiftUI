//
//  CheckboxToggleStyle.swift
//  Utils
//
//  Created by Jmy on 2023/06/05.
//

import SwiftUI

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
        .padding(.init(top: 20, leading: 20, bottom: .toastBottom, trailing: 20))
        .frame(maxWidth: .infinity)
        .background(Color.gray700.cornerRadius(20, corners: [.topLeft, .topRight]))
    }

    var titleView: some View {
        Text("약관에 동의해주세요")
            .foregroundColor(Color.gray100)
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

                    NavigationLink {
                        HTMLWebNavigationView(title: term.name, html: term.content)
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

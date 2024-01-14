//
//  SelectListTextField.swift
//  Utils
//
//  Created by Jmy on 2023/06/16.
//

import SwiftUI

struct ExperienceTypeDTO: Codable, Hashable, Identifiable {
    enum CodingKeys: String, CodingKey {
        case id
        case fullName
        case imageUrl
    }

    let id: Int
    var fullName: String
    let imageUrl: String?
}

struct SelectListTextField: View {
    @Binding var text: String
    let placeholder: String

    @FocusState private var isFocused: Bool

    var body: some View {
        TextField(
            "",
            text: $text,
            prompt: promptText as? Text
        )
        .font(.subheadline2)
        .foregroundColor(.gray100)
        .padding(16)
        .background(Color.gray700)
        .cornerRadius(8)
        .focused($isFocused)
        .disabled(true)
        .overlay {
            Image.chevron_down
                .renderingMode(.template)
                .foregroundColor(.gray100)
                .frame(maxWidth: .infinity, alignment: .trailing)
                .padding(16)
        }
    }

    var promptText: some View {
        Text(placeholder)
            .foregroundColor(.gray300)
    }
}

struct SelectListTextFieldView: View {
    @State private var experienceTypes = [ExperienceTypeDTO]()
    @State private var selectedExperienceType = ExperienceTypeDTO(id: 0, fullName: "", imageUrl: "")
    @State private var isShowingDialog = false

    var body: some View {
        func getReviewExperienceTypes() {
            experienceTypes = [
                ExperienceTypeDTO(id: 0, fullName: "0", imageUrl: ""),
                ExperienceTypeDTO(id: 1, fullName: "1", imageUrl: ""),
                ExperienceTypeDTO(id: 2, fullName: "2", imageUrl: ""),
                ExperienceTypeDTO(id: 3, fullName: "3", imageUrl: ""),
            ]
        }

        let buttons: [ActionSheet.Button] = experienceTypes.map { experienceType in
            .default(Text(experienceType.fullName)) {
                selectedExperienceType = experienceType
            }
        } + [.cancel()]

        return SelectListTextField(text: $selectedExperienceType.fullName, placeholder: "제품을 접하게 된 경로를 선택해 주세요.")
            .onAppear {
                getReviewExperienceTypes()
            }
            .onTapGesture {
                // endEditing()
                isShowingDialog = true
            }
            .actionSheet(isPresented: $isShowingDialog) {
                ActionSheet(
                    title: Text("경험 경로"),
                    message: Text("제품을 접하게 된 경로를 선택해 주세요."),
                    buttons: buttons
                )
            }
            .frame(maxWidth: .infinity)
    }
}

#Preview {
    SelectListTextFieldView()
        .padding()
}

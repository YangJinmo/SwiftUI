//
//  InfoView.swift
//  Utils
//
//  Created by Jmy on 9/6/24.
//

import SwiftUI

struct InfoView: View {
    var body: some View {
        VStack {
            // UIDevice
            Group {
                Text(UIDevice.current.identifierForVendor?.uuidString ?? "")
                Text(UIDevice.current.systemName) // iOS
                Text(UIDevice.current.systemVersion) // 17.5
            }
            .foregroundColor(.green)

            // TimeZone
            Text(TimeZone.current.identifier) // Asia/Seoul
                .foregroundColor(.red)

            // Locale
            Group {
                Text(Locale.current.languageCode ?? "") // en
                Text(Locale.current.languageCode?.description ?? "") // en

                if #available(iOS 16, *) {
                    Text("\(Locale.current.language.languageCode ?? "")") // en
                    Text(Locale.current.language.languageCode?.identifier ?? "") // en
                } else {
                    // Fallback on earlier versions
                }
            }
            .foregroundColor(.blue)

            Group {
                Text(Locale.current.regionCode ?? "") // KR
                Text(Locale.current.regionCode?.description ?? "") // KR

                if #available(iOS 16, *) {
                    Text("\(Locale.current.region ?? "")") // KR
                    Text(Locale.current.region?.identifier ?? "") // KR
                } else {
                    // Fallback on earlier versions
                }
            }
            .foregroundColor(.purple)

            Group {
                ForEach(Locale.preferredLanguages, id: \.self) { identifier in
                    Text(identifier) // en-KR, ko-KR
                }
                .foregroundColor(.orange)

                Text(Locale.current.identifier) // en_KR
                    .foregroundColor(.pink)
            }
        }
        .onAppear {
            // UIDevice
            print("UIDevice.current.identifierForVendor?.uuidString:", UIDevice.current.identifierForVendor?.uuidString ?? "")
            print("UIDevice.current.systemName:", UIDevice.current.systemName)
            print("UIDevice.current.systemVersion:", UIDevice.current.systemVersion)

            // TimeZone
            print("TimeZone.current.identifier:", TimeZone.current.identifier)

            // Locale
            print("Locale.current.identifier:", Locale.current.identifier)

            if #available(iOS 16, *) {
                print("Locale.current.region:", Locale.current.region ?? "")
                print("Locale.current.region?.identifier:", Locale.current.region?.identifier ?? "")
                print("Locale.current.language.languageCode:", Locale.current.language.languageCode ?? "")
                print("Locale.current.language.languageCode?.identifier:", Locale.current.language.languageCode?.identifier ?? "")
            } else {
                print("Locale.current.regionCode:", Locale.current.regionCode ?? "")
                print("Locale.current.regionCode?.description:", Locale.current.regionCode?.description ?? "")
                print("Locale.current.languageCode:", Locale.current.languageCode ?? "")
                print("Locale.current.languageCode?.description:", Locale.current.languageCode?.description ?? "")
            }
        }
    }
}

#Preview {
    InfoView()
}

import SwiftUI

enum AppLanguage: String, CaseIterable, Identifiable {
    case english = "en"
    case korean = "ko"
    case indonesian = "id"
    case japanese = "ja"
    case chineseTraditional = "zh-Hant"
    case chineseSimplified = "zh-Hans"
    case spanish = "es"
    case vietnamese = "vi"
    case thai = "th"

    var id: String { rawValue }

    var name: String {
        switch self {
        case .english: return "English"
        case .korean: return "한국어"
        case .indonesian: return "Bahasa Indonesia"
        case .japanese: return "日本語"
        case .chineseTraditional: return "中文 (繁體)"
        case .chineseSimplified: return "中文 (简体)"
        case .spanish: return "Español"
        case .vietnamese: return "Tiếng Việt"
        case .thai: return "ภาษาไทย"
        }
    }
}

struct RadioButton: View {
    let isSelected: Bool

    var body: some View {
        ZStack {
            Circle()
                .stroke(isSelected ? Color.pink : Color.gray, lineWidth: 1)
                .frame(width: 20, height: 20)

            if isSelected {
                Circle()
                    .fill(Color.pink)
                    .frame(width: 10, height: 10)
            }
        }
    }
}

struct RadioDetailButton: View {
    let text: String
    let isSelected: Bool

    var body: some View {
        HStack(spacing: 12) {
            RadioButton(isSelected: isSelected)

            Text(text)
                .fontWeight(isSelected ? .semibold : .regular)

            Spacer()
        }
    }
}

struct LanguageSelectorView: View {
    @AppStorage("appLanguage") private var appLanguage = AppLanguage.english.rawValue

    var body: some View {
        List(AppLanguage.allCases) { language in
            Button {
                appLanguage = language.rawValue
            } label: {
                RadioDetailButton(
                    text: language.name,
                    isSelected: appLanguage == language.rawValue
                )
            }
            .frame(height: 56)
            .listRowInsets(EdgeInsets())
            .listRowSeparator(.hidden)
            .listRowBackground(Color.clear)
        }
        .listStyle(.plain)
        .padding(.horizontal, 16)
        .navigationTitle("Language")
    }
}

struct LanguageSelectorViewPreview: View {
    @AppStorage("appLanguage") private var appLanguage = AppLanguage.english.rawValue

    var body: some View {
        NavigationView {
            VStack {
                Text("Current Language: \(AppLanguage(rawValue: appLanguage)?.name ?? "Unknown")")
                    .padding()

                NavigationLink("Change Language", destination: LanguageSelectorView())
            }
        }
        .environment(\.locale, .init(identifier: appLanguage))
    }
}

#Preview {
    LanguageSelectorViewPreview()
}

//
//  ContentView.swift
//  GitHub
//
//  Created by Jmy on 2023/09/11.
//

import Combine
import SwiftSoup
import SwiftUI

struct ContentView: View {
    @State private var user: GitHubUser?
    @State private var titleKey: LocalizedStringKey = "Username"
    @State private var username: String = "YangJinmo"
    @State private var errorMessage: String = ""
    @FocusState private var isFocused: Bool
    private var cancellables: Set<AnyCancellable> = []

    @State private var contributes: [ContributeData] = []
    @State private var streaks: ContributeData = ContributeData(count: 0, weekend: "", date: "")

    var body: some View {
        VStack {
            AsyncImage(url: URL(string: user?.avatarUrl ?? "")) { image in
                image
                    .resizable()
                    .aspectRatio(contentMode: .fit)
                    .clipShape(Circle())
                    .overlay(
                        Circle()
                            .stroke(
                                Color(uiColor: .secondaryLabel),
                                lineWidth: 0.5
                            )
                    )
            } placeholder: {
                Circle()
                    .foregroundColor(.secondary)
            }
            .frame(width: 120, height: 120)

            if let name = user?.name {
                Text(name)
                    .bold()
                    .font(.title3)

                Text(user?.login ?? "")
            } else {
                Text(user?.login ?? "")
                    .bold()
                    .font(.title3)
            }

            Text(user?.bio ?? "")
                .fontWeight(.medium)
                .padding(.top, 2)

            HStack(spacing: 4) {
                Image(systemName: "person.2")

                Text("\(user?.followers ?? 0)")
                    .fontWeight(.semibold)

                Text("followers")

                Text("·")

                Text("\(user?.following ?? 0)")
                    .fontWeight(.semibold)

                Text("following")
            }
            .padding(.top, 2)

            Button {
                guard let url = URL(string: user?.htmlUrl ?? "") else {
                    return
                }

                UIApplication.shared.open(url)
            } label: {
                Text(user?.htmlUrl ?? "")
            }
            .padding(.top, 2)

            VStack(spacing: 4) {
                Text("Streaks")
                    .bold()

                HStack {
                    Text("\(streaks.date)")

                    Text("\(streaks.weekend)")

                    Text("\(streaks.count)")
                }
                .fontWeight(.semibold)
                .foregroundColor(streaks.count == 0 ? .red : .green)
            }
            .padding(.top, 2)

            VStack(spacing: 4) {
                Text("Contributes")
                    .bold()

                ForEach(contributes, id: \.date) { contribute in
                    HStack(spacing: 2) {
                        Text("\(contribute.date)")

                        Text("\(contribute.weekend)")

                        Text("\(contribute.count)")
                    }
                    .fontWeight(.semibold)
                    .foregroundColor(contribute.count == 0 ? .red : .green)
                }
            }
            .padding(.top, 2)

            Spacer()

            TextField(titleKey, text: $username)
                .bold()
                .font(.title3)
                .submitLabel(.search)
                .padding(8)
                .focused($isFocused)
                .overlay(
                    RoundedRectangle(cornerRadius: 8)
                        .strokeBorder(
                            isFocused
                                ? Color.accentColor
                                : Color(uiColor: .secondaryLabel),
                            lineWidth: 0.5
                        )
                )
                .overlay(
                    HStack {
                        Spacer()

                        Text(errorMessage)
                            .foregroundColor(Color(uiColor: .secondaryLabel))
                            .padding()
                    }
                )
                .onSubmit {
                    Task {
                        await fetchUser()
                    }
                }
        }
        .padding()
        .task {
            await fetchUser()
        }
        .onAppear {
            fetchContributionsByUserame(username: username)
        }
    }

    private func fetchUser() async {
        Task {
            do {
                user = try await getUser(username: username)
            } catch {
                handleGHError(error)
            }
        }
    }

    private func getUser(username: String) async throws -> GitHubUser {
        errorMessage = ""

        let endPoint = "https://api.github.com/users/\(username)"

        guard let url = URL(string: endPoint) else {
            throw GHError.invalidURL
        }

        let (data, response) = try await URLSession.shared.data(from: url)

        guard let response = response as? HTTPURLResponse, response.statusCode == 200 else {
            throw GHError.invalidResponse
        }

        do {
            let decoder = JSONDecoder()
            decoder.keyDecodingStrategy = .convertFromSnakeCase
            return try decoder.decode(GitHubUser.self, from: data)
        } catch {
            throw GHError.invalidData
        }
    }

    private func fetchContributionsByUserame(username: String, isFriend: Bool = false, group: DispatchGroup? = nil) {
        guard let targetURL = URL(string: "https://github.com/users/\(username)/contributions") else { return }
        URLSession.shared.dataTask(with: targetURL) { data, response, error in
//            guard let self = self else { return }

            if error != nil {
                self.showError()
                return
            }

            guard let httpResponse = response as? HTTPURLResponse, (200 ... 299).contains(httpResponse.statusCode) else {
                self.showError()
                return
            }

            guard let mimeType = httpResponse.mimeType,
                  mimeType == "text/html",
                  let data = data,
                  let html = String(data: data, encoding: .utf8)
            else {
                self.showError()
                return
            }

            let contributeDataList = self.parseHtmltoData(html: html)
            self.contributes = contributeDataList
            self.streaks = self.parseHtmltoDataForCount(html: html)

            if group != nil {
                group?.leave()
            }
        }
        .resume()
    }

    private func parseHtmltoData(html: String) -> [ContributeData] {
        let isoDateFormatter = ISO8601DateFormatter()
        isoDateFormatter.formatOptions = [.withFullDate]

        do {
            let doc: Document = try SwiftSoup.parse(html)
            let rects: Elements = try doc.getElementsByTag(ParseKeys.rect)
            let days: [Element] = rects.array().filter { $0.hasAttr(ParseKeys.date) }
            let sortedDays = sortDaysByDate(days, with: isoDateFormatter)

            let weekend = sortedDays.suffix(Consts.fetchCount)
            let contributeDataList = weekend.map(mapFunction)
            return contributeDataList

        } catch {
            return []
        }
    }

    private func sortDaysByDate(_ days: [Element], with dateFormatter: ISO8601DateFormatter) -> [Element] {
        return days.sorted { element1, element2 -> Bool in
            guard let date1 = try? element1.attr(ParseKeys.date),
                  let date2 = try? element2.attr(ParseKeys.date),
                  let date1Value = dateFormatter.date(from: date1),
                  let date2Value = dateFormatter.date(from: date2) else {
                return false
            }
            return date1Value < date2Value
        }
    }

    private func parseHtmltoDataForCount(html: String) -> ContributeData {
        do {
            let doc: Document = try SwiftSoup.parse(html)
            let rects: Elements = try doc.getElementsByTag(ParseKeys.rect)
            let days: [Element] = rects.array().filter { $0.hasAttr(ParseKeys.date) }
            let count = days.suffix(Consts.fetchStreak)
            var contributeLastDate = count.map(mapFunction)
            contributeLastDate.sort { $0.date > $1.date }
            for index in 0 ..< contributeLastDate.count {
                if contributeLastDate[index].count == .zero {
                    return contributeLastDate[index]
                }
                if index == (contributeLastDate.count - 1) {
                    return ContributeData(
                        count: 1000,
                        weekend: contributeLastDate[index].weekend,
                        date: contributeLastDate[index].date
                    )
                }
            }
            return ContributeData(count: 0, weekend: "", date: "")
        } catch {
            return ContributeData(count: 0, weekend: "", date: "")
        }
    }

    private func mapFunction(ele: Element) -> ContributeData {
        guard let attr = ele.getAttributes() else { return ContributeData(count: 0, weekend: "", date: "") }
        let date: String = attr.get(key: ParseKeys.date)

        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd"
        dateFormatter.locale = Locale.current
        dateFormatter.timeZone = TimeZone.current

        let dateForWeekend = dateFormatter.date(from: date)
        guard let weekend = dateForWeekend?.dayOfWeek() else { return ContributeData(count: 0, weekend: "", date: "") }

        do {
            if let count = try selectCountFrom(sentence: ele.text()) {
                return ContributeData(count: count, weekend: weekend, date: date)
            } else {
                return ContributeData(count: 0, weekend: "", date: "")
            }
        } catch {
            return ContributeData(count: 0, weekend: "", date: "")
        }
    }

    private func selectCountFrom(sentence: String) -> Int? {
        guard let firstVerse = sentence.components(separatedBy: " ").first else {
            return nil
        }
        guard let integerValue = Int(firstVerse) else {
            return 0
        }
        return integerValue
    }

    private func handleGHError(_ error: Error) {
        switch error {
        case GHError.invalidURL:
            errorMessage = "Invalid URL"
        case GHError.invalidResponse:
            errorMessage = "Invalid Response"
        case GHError.invalidData:
            errorMessage = "Invalid Data"
        default:
            errorMessage = "Unexpected Error"
        }
    }

    private func showError() {
        DispatchQueue.main.async {
            // self.statusItem?.button?.title = Localized.error
            print("Error")
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}

struct GitHubUser: Codable {
    let login: String
    let name: String?
    let avatarUrl: String?
    let bio: String?
    let followers: Int
    let following: Int
    let htmlUrl: String
}

enum GHError: Error {
    case invalidURL
    case invalidResponse
    case invalidData
}

import Foundation

class ContributeData {
    let count: Int
    let weekend: String
    let date: String
    private var friendContributeData: ContributeData?

    init(count: Int, weekend: String, date: String) {
        self.count = count
        self.weekend = weekend
        self.date = date
    }

    private func getGoalCountString(_ goal: Int) -> String {
        return String(goal - count)
    }

    public func merge(contributeData: ContributeData) {
        friendContributeData = contributeData
    }
}

import Foundation

enum ParseKeys {
    static let date = "data-date"
    static let rect = "td"
}

import Foundation

enum Consts {
    static let fetchCount = 10
    static let fetchStreak = 1000
    static let refreshInterval = 10
    static let contributionTag = 1
    static let goalTag = 9
    static let usernameDefaultKey = "username"
    static let friendUsernameDefaultKey = "friend_username"
    static let goalDefaultKey = "goal"
}

import Foundation

extension Date {
    func dayOfWeek() -> String {
        let dateFormatter = DateFormatter()
        let prefLanguage = Locale.preferredLanguages[0]

        dateFormatter.locale = NSLocale(localeIdentifier: prefLanguage) as Locale
        dateFormatter.dateFormat = "E"
        return dateFormatter.string(from: self).capitalized
    }

    func timeAgoSince() -> String {
        let calendar = Calendar.current
        let now = Date()

        let unitFlags: NSCalendar.Unit = [.day]
        let components = (calendar as NSCalendar).components(unitFlags, from: self, to: now, options: [])

        guard let day = components.day else { return "0" }

        return "\(day)"
    }
}

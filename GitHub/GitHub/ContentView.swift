//
//  ContentView.swift
//  GitHub
//
//  Created by Jmy on 2023/09/11.
//

import Combine
import SwiftUI

struct ContentView: View {
    @State private var user: GitHubUser?
    @State private var titleKey: LocalizedStringKey = "Username"
    @State private var username: String = "YangJinmo"
    @State private var errorMessage: String = ""
    @FocusState private var isFocused: Bool
    private var cancellables: Set<AnyCancellable> = []

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
}

enum GHError: Error {
    case invalidURL
    case invalidResponse
    case invalidData
}

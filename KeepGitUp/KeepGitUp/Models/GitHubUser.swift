//
//  GitHubUser.swift
//  KeepGitUp
//
//  Created by Jmy on 2023/11/23.
//

struct GitHubUser: Codable {
    let login: String
    let name: String?
    let avatarUrl: String?
    let bio: String?
    let followers: Int
    let following: Int
    let htmlUrl: String
}

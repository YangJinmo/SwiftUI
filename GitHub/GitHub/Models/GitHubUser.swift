//
//  GitHubUser.swift
//  GitHub
//
//  Created by Jmy on 2023/11/14.
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

//
//  Users.swift
//  GithubSearcher
//
//  Created by nakajima on 2021/09/22.
//

import Foundation

/// GithubのAPIが返すユーザーデータ。必要なプロパティのみを取得する
struct Users: Codable {
    let totalCount: Int
    let incompleteResults: Bool
    let items: [User]

    private enum CodingKeys: String, CodingKey {
        case totalCount = "total_count"
        case incompleteResults = "incomplete_results"
        case items
    }
}

struct User: Codable, Identifiable {
    let id = UUID()
    let login: String
    let avatarUrl: String
    let reposUrl: String

    private enum CodingKeys: String, CodingKey {
        case login
        case avatarUrl = "avatar_url"
        case reposUrl = "repos_url"
    }
}

//
//  GithubModel.swift
//  GithubSearcher
//
//  Created by nakajima on 2021/09/22.
//

import Foundation

enum Result<T> {
    case success(T)
    case failure(Error)
}

enum ModelError: Error {
    case invalidText
}

protocol ModelProtocol {
    func validate(text: String?) -> Result<Void>
    func searchGithubUser(query: String) -> User
}

struct User: Codable {
    let total_count: Int
    let incomplete_results: Bool
    let items: [Item]
    
    struct Item: Codable {
        let login: String
        let id: Int
        let node_id: String
        let avatar_url: URL
        let gravatar_id: String?
        let url: URL
        let html_url: URL
        let followers_url: URL
        let subscriptions_url: URL
        let organizations_url: URL
        let repos_url: URL
        let received_events_url: URL
        let type: String
        let score: Double
    }
}

struct GithubModel {
//    let url = URL(string: "https://api.github.com/search/users?q=")
}

//
//  GithubModel.swift
//  GithubSearcher
//
//  Created by nakajima on 2021/09/22.
//

import Foundation
import ComposableArchitecture

struct GithubApi {
    var users: (String) -> Effect<[User], ModelError>
}

extension GithubApi {
    static let live = GithubApi(
        users: { query in
            var components = URLComponents()
            components.scheme = "https"
            components.host = "api.github.com"
            components.path = "/search/users"
            components.queryItems = [URLQueryItem(name: "q", value: query)]

            return URLSession.shared.dataTaskPublisher(for: components.url!)
                .map { data, _ in data }
                .decode(type: Users.self, decoder: JSONDecoder())
                .mapError { error in ModelError.jsonParseError(error.localizedDescription) }
                .map { return $0.items }
                .eraseToEffect()
        }
    )
}

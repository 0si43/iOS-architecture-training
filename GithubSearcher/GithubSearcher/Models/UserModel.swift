//
//  UserModel.swift
//  GithubSearcher
//
//  Created by nakajima on 2021/09/22.
//

import Foundation

/// GithubのREST APIを叩いて、ユーザー一覧を返すクラス
class UserModel: ObservableObject {
    @Published var users = [User]()
    @Published var isNotFound = false
    @Published var error: ModelError?
    
    private var endpoint: URLComponents {
      var components = URLComponents()
      components.scheme = "https"
      components.host = "api.github.com"
      components.path = "search/users"
      return components
    }

    @MainActor
    public func fetch(query: String) async {
        users = [User]()
        error = nil
        isNotFound = false

        guard let encodedQuery = query.addingPercentEncoding(withAllowedCharacters: .urlPathAllowed) else {
            error =  .encodingError
            return
        }
        
        var urlComponents = endpoint
        urlComponents.queryItems = [URLQueryItem(name: "q", value: encodedQuery)]
        guard let url = urlComponents.url else {
            error = .urlError
            return
        }
        
        do {
            let (data, _) = try await URLSession.shared.data(for: URLRequest(url: url))

            guard let users = try? JSONDecoder().decode(Users.self, from: data) else {
                error = .jsonParseError(String(data: data, encoding: .utf8) ?? "")
                return
            }

            if users.totalCount == 0 {
                isNotFound = true
                self.users = [User]()
                return
            }
            self.users = users.items
        } catch {
            self.error = .responseError(error)
        }
    }
}

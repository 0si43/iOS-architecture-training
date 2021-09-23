//
//  UserModel.swift
//  GithubSearcher
//
//  Created by nakajima on 2021/09/22.
//

import Foundation

/// GithubのREST APIを叩いて、ユーザー一覧を返すクラス
class UserModel: ObservableObject {
    private let urlString = "https://api.github.com/search/users?q="
    @Published var users = [User]()
    @Published var isNotFound = false
    @Published var error: ModelError?

    @MainActor
    public func fetch(query: String) async {
        users = [User]()
        error = nil
        isNotFound = false

        guard let encodedQuery = query.addingPercentEncoding(withAllowedCharacters: .urlPathAllowed) else {
            error =  .encodingError
            return
        }

        guard let url = URL(string: urlString + encodedQuery) else {
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

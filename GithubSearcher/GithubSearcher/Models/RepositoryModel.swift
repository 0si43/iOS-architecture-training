//
//  RepositoryModel.swift
//  GithubSearcher
//
//  Created by nakajima on 2021/09/22.
//

import Foundation

/// GithubのREST APIを叩いて、リポジトリ一覧を返すクラス
class RepositoryModel: ObservableObject {
    private let urlString = "https://api.github.com/search/users?q="
    @Published var users = [User]()
    @Published var isNotFound = false
    @Published var error: ModelError?

    public func fetch(query: String) {
        users = [User]()
        error = nil
        isNotFound = false

        guard let encodedQuery = query.addingPercentEncoding(withAllowedCharacters: .urlPathAllowed) else {
            publishError(type: .encodingError)
            return
        }

        guard let url = URL(string: urlString + encodedQuery) else {
            publishError(type: .urlError)
            return
        }

        URLSession.shared.dataTask(with: url) {[weak self](data, _, error) in
            if let error = error {
                self?.publishError(type: .responseError(error))
                return
            }

            guard let data = data else {
                self?.publishError(type: .responseDataEmpty)
                return
            }

            guard let users = try? JSONDecoder().decode(Users.self, from: data) else {
                self?.publishError(type: .jsonParseError(String(data: data, encoding: .utf8) ?? ""))
                return
            }

            DispatchQueue.main.async {
                if users.totalCount == 0 {
                    self?.isNotFound = true
                    self?.users = [User]()
                    return
                }
                self?.users = users.items
            }
        }.resume()
    }

    private func publishError(type: ModelError) {
        DispatchQueue.main.async {[weak self] in
            self?.error = type
        }
    }
}

//
//  GithubModel.swift
//  GithubSearcher
//
//  Created by nakajima on 2021/09/22.
//

import Foundation

/// Modelオブジェクトが準拠するプロトコル
protocol SearchUserModelInput {
    /// QueryをもとにGithubのユーザー検索APIを叩いて、結果をPublishする
    func fetchUser(query: String, completion: @escaping (Result<[User], ModelError>) -> Void)
}

/// GithubのREST APIを叩いて、結果を返すクラス
class GithubModel: ObservableObject, SearchUserModelInput {
    @Published var repositories = [Repository]()
    @Published var isLoading = true

    @Published var error: ModelError?

    private var endpoint: URLComponents {
        var components = URLComponents()
        components.scheme = "https"
        components.host = "api.github.com"
        return components
    }

    func fetchUser(query: String, completion: @escaping (Result<[User], ModelError>) -> Void) {
        guard !query.isEmpty,
              let url = userSearchEndpoint(query: query) else {
            completion(.failure(.urlError))
            return
        }

        Task {
            let result = await fetch(url: url)

            switch result {
            case .success(let data):
                guard let users = try? JSONDecoder().decode(Users.self, from: data) else {
                    completion(.failure(.jsonParseError(String(data: data, encoding: .utf8) ?? "")))
                    return
                }
                completion(.success(users.items))
            case .failure(let error):
                completion(.failure(.responseError(error)))
            }
        }
    }

    private func userSearchEndpoint(query: String) -> URL? {
        guard let encodedQuery = query.addingPercentEncoding(withAllowedCharacters: .urlPathAllowed) else {
            return nil
        }

        var urlComponents = endpoint
        urlComponents.path = "/search/users"
        urlComponents.queryItems = [URLQueryItem(name: "q", value: encodedQuery)]
        guard let url = urlComponents.url else {
            error = .urlError
            return nil
        }

        return url
    }

    @MainActor
    private func fetch(url: URL) async -> Result<Data, Error> {
        do {
            let (data, _) = try await URLSession.shared.data(for: URLRequest(url: url))
            return .success(data)
        } catch {
            return .failure(error)
        }
    }

    /// Githubのあるユーザーのリポジトリ一覧を取得して、結果をPublishする
    public func fetchRepositories(urlString: String) {
        repositories = [Repository]()
        error = nil
        isLoading = true
        defer {
            isLoading = false
        }

        guard let url = URL(string: urlString) else {
            error = .urlError
            return
        }

        Task {
            let result = await fetch(url: url)

            switch result {
            case .success(let data):
                guard let repositories = try? JSONDecoder().decode([Repository].self, from: data) else {
                    error = .jsonParseError(String(data: data, encoding: .utf8) ?? "")
                    return
                }
                self.repositories = repositories
            case .failure(let error):
                self.error = .responseError(error)
            }
        }
    }
}

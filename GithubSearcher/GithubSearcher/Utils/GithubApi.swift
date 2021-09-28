//
//  GithubModel.swift
//  GithubSearcher
//
//  Created by nakajima on 2021/09/22.
//

import Foundation

/// Modelオブジェクトが準拠するプロトコル
protocol ApiRequestable {
    func fetchUser(query: String, completion: @escaping (Result<[User], ModelError>) -> Void)
    func fetchRepository(urlString: String, completion: @escaping (Result<[Repository], ModelError>) -> Void)
}

/// GithubのREST APIを叩いて、結果を返すクラス
struct GithubApi: ApiRequestable {
    private var endpoint: URLComponents {
        var components = URLComponents()
        components.scheme = "https"
        components.host = "api.github.com"
        return components
    }

    /// QueryをもとにGithubのユーザー検索APIを叩いて、結果をcallbackする
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

    /// Githubのあるユーザーのリポジトリ一覧を取得して、結果をcallbackする
    func fetchRepository(urlString: String, completion: @escaping (Result<[Repository], ModelError>) -> Void) {
        guard let url = URL(string: urlString) else {
            completion(.failure(.urlError))
            return
        }

        Task {
            let result = await fetch(url: url)

            switch result {
            case .success(let data):
                guard let repositories = try? JSONDecoder().decode([Repository].self, from: data) else {
                    completion(.failure(.jsonParseError(String(data: data, encoding: .utf8) ?? "")))
                    return
                }
                completion(.success(repositories))
            case .failure(let error):
                completion(.failure(.responseError(error)))
            }
        }
    }
}

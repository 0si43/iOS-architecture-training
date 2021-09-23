//
//  GithubModel.swift
//  GithubSearcher
//
//  Created by nakajima on 2021/09/22.
//

import Foundation

/// APIを叩く際に発生する可能性のあるエラー一覧
enum ModelError: Error {
    case encodingError
    case urlError
    case responseError(Error)
    case responseDataEmpty
    case jsonParseError(String)

    var localizedDescription: String {
        switch self {
        case .encodingError: return "エンコーディングできない文字列が入ってきました"
        case .urlError: return "URLに変換しようとしたところで失敗しました"
        case .responseError(let error): return "API叩いたらエラーが返ってきました。詳細: （\(error)）"
        case .responseDataEmpty: return "APIから取得したデータがnilでした"
        case .jsonParseError(let message): return "JSONのパースに失敗しました。失敗したデータ: (\(message)"
        }
    }
}

/// GithubのREST APIを叩いて、その結果を返すクラス
class GithubModel: ObservableObject {
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

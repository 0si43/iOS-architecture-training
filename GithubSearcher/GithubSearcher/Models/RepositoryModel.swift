//
//  RepositoryModel.swift
//  GithubSearcher
//
//  Created by nakajima on 2021/09/22.
//

import Foundation

/// GithubのREST APIを叩いて、リポジトリ一覧を返すクラス
class RepositoryModel: ObservableObject {
    @Published var isLoading = true
    @Published var repositories = [Repository]()
    @Published var error: ModelError?

    public func fetch(urlString: String) {
        guard let url = URL(string: urlString) else {
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

            guard let repositories = try? JSONDecoder().decode([Repository].self, from: data) else {
                self?.publishError(type: .jsonParseError(String(data: data, encoding: .utf8) ?? ""))
                return
            }

            DispatchQueue.main.async {
                self?.repositories = repositories
                self?.isLoading = false
            }
        }.resume()
    }

    private func publishError(type: ModelError) {
        DispatchQueue.main.async {[weak self] in
            self?.error = type
            self?.isLoading = false
        }
    }
}

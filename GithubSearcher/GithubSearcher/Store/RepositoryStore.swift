//
//  RepositoryStore.swift
//  GithubSearcher
//
//  Created by nakajima on 2021/09/28.
//

import Foundation

class RepositoryStore: Store {
    static let shared = RepositoryStore(dispatcher: .shared)
    @Published var isLoading = true
    @Published var repositories = [Repository]()

    override func onDispatch(_ action: Action) {
        switch action {
        case .searchUser(_):
            return
        case .startRepositoriesLoding:
            isLoading = true
        case .getReositories(let repositories):
            self.repositories = repositories
            isLoading = false
        }
    }
}

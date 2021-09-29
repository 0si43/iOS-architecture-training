//
//  UserSearchPresenter.swift
//  GithubSearcher
//
//  Created by nakajima on 2021/09/22.
//

import Combine

/// ユーザー検索のViewModel
class UserSearchPresenter: ObservableObject {
    let model: ModelInput
    private(set) var objectWillChange = ObservableObjectPublisher()
    @Published var users: [User]
    @Published var isNotFound: Bool
    @Published var error: ModelError?

    init(model: GithubInteractor = GithubInteractor(),
         users: [User] = [User](), isNotFound: Bool = false, error: ModelError? = nil) {
        self.model = model
        self.users = users
        self.isNotFound = isNotFound
        self.error = error
    }

    /// Modelにロード開始を要求する
    func loadStart(query: String) {
        guard !query.isEmpty else { return }
        users = [User]()
        isNotFound = false
        error = nil

        model.fetchUser(query: query) { [weak self] result in
            switch result {
            case .success(let users):
                if !users.isEmpty {
                    self?.users = users
                } else {
                    self?.isNotFound = true
                }
            case .failure(let error):
                self?.error = error
            }
            self?.objectWillChange.send()
        }
    }
}

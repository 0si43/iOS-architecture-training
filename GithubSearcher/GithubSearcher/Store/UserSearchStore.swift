//
//  UserSearchStore.swift
//  GithubSearcher
//
//  Created by nakajima on 2021/09/28.
//

import Foundation

class UserSearchStore: Store {
    static let shared = UserSearchStore(dispatcher: .shared)
    @Published var users = [User]()

    override func onDispatch(_ action: Action) {
        switch action {
        case .searchUser(let users):
            self.users = users
        case .getReositories(_):
            return
        }
    }
}

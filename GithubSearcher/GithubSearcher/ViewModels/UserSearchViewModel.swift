//
//  UserSearchViewModel.swift
//  GithubSearcher
//
//  Created by nakajima on 2021/09/22.
//

import SwiftUI
import UIKit

/// ユーザー検索のViewModel
class UserSearchViewModel: ObservableObject {
    let model: GithubModel
    @Published var users: [User]
    @Published var isNotFound: Bool
    @Published var error: ModelError?

    init(model: GithubModel = GithubModel(),
         users: [User] = [User](), isNotFound: Bool = false, error: ModelError? = nil) {
        self.model = model
        self.users = users
        self.isNotFound = isNotFound
        self.error = error
    }

    /// Modelにロード開始を要求する
    public func loadStart(query: String) {
        //        model.fetchUser(query: query)
    }
}

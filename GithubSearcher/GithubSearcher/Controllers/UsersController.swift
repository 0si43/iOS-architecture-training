//
//  UsersController.swift
//  GithubSearcher
//
//  Created by nakajima on 2021/09/22.
//

import Foundation

/// イベントの制御を行うクラス
final class UsersController: ObservableObject {
    private let model: UserModel
    private let query: String

    init(model: UserModel, query: String) {
        self.model = model
        self.query = query
    }

    /// Modelにロード開始を要求する
    public func loadStart() {
        model.fetch(query: query)
    }
}

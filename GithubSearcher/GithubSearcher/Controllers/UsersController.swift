//
//  UsersController.swift
//  GithubSearcher
//
//  Created by nakajima on 2021/09/22.
//

import Foundation

/// イベントの制御を行うクラス
final class UsersController: ObservableObject {
    private let model: GithubModel
    private let query: String

    init(model: GithubModel, query: String) {
        self.model = model
        self.query = query
    }

    /// Modelにロード開始を要求する
    public func loadStart() {
        do {
            try model.fetch(query: query)
        } catch ModelError.encodingError {
            print("URLエンコーディングに失敗しました")
        } catch ModelError.urlError {
            print("String -> URLの変換に失敗しました")
        } catch {
            print("その他のエラーです")
        }
    }
}

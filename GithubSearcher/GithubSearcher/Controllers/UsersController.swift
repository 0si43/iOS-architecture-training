//
//  UsersController.swift
//  GithubSearcher
//
//  Created by nakajima on 2021/09/22.
//

import Foundation

final class UsersController: ObservableObject {
    init(model: GithubModel, query: String) {
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

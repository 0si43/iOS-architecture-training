//
//  RepositoryController.swift
//  GithubSearcher
//
//  Created by nakajima on 2021/09/22.
//

import Foundation

/// イベントの制御を行う構造体
struct RepositoryController {
    let model: RepositoryModel
    let urlString: String

    /// Modelにロード開始を要求する
    public func loadStart() {
        model.fetch(urlString: urlString)
    }

}

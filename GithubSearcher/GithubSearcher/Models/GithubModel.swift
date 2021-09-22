//
//  GithubModel.swift
//  GithubSearcher
//
//  Created by nakajima on 2021/09/22.
//

import Foundation

enum Result<T> {
    case success(T)
    case failure(Error)
}

enum ModelError: Error {
    case invalidText
}

protocol ModelProtocol {
    func validate(text: String?) -> Result<Void>
    func searchGithubUser(query: String) -> User
}

struct GithubModel {
    //    let url = URL(string: "https://api.github.com/search/users?q=")
}

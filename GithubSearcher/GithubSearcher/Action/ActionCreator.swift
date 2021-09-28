//
//  ActionCreator.swift
//  GithubSearcher
//
//  Created by nakajima on 2021/09/28.
//

import Foundation

final class ActionCreator {
    private let dispatcher: Dispatcher
    private let githubApi: ApiRequestable

    init(dispatcher: Dispatcher = .shared,
         githubApi: ApiRequestable = GithubApi()) {
        self.dispatcher = dispatcher
        self.githubApi = githubApi
    }
}

// MARK: Search User

extension ActionCreator {
    func searchUser(query: String) {
        githubApi.fetchUser(query: query) { [weak self] result in
            switch result {
            case .success(let users):
                self?.dispatcher.dispatch(.searchUser(users))
            case .failure(let error):
                print(error.localizedDescription)
            }
        }
    }
}

// MARK: Get Repositories

extension ActionCreator {
    func startRepositoriesLoding() {
        dispatcher.dispatch(.startRepositoriesLoding)
    }

    func getRepositories(urlString: String) {
        githubApi.fetchRepository(urlString: urlString) { [weak self] result in
            switch result {
            case .success(let repositories):
                self?.dispatcher.dispatch(.getReositories(repositories))
            case .failure(let error):
                print(error.localizedDescription)
            }
        }
    }
}

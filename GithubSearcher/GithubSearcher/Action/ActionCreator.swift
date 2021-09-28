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

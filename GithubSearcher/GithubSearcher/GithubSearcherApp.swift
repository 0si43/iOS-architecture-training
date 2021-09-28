//
//  GithubSearcherApp.swift
//  GithubSearcher
//
//  Created by nakajima on 2021/09/21.
//

import SwiftUI

@main
struct GithubSearcherApp: App {
    private let actionCreator = ActionCreator()
    private let userSearchStore = UserSearchStore.shared

    var body: some Scene {
        WindowGroup {
            UserSearchView(actionCreator: actionCreator, userSearchStore: userSearchStore)
        }
    }
}

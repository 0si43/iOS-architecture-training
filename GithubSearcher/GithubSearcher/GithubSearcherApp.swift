//
//  GithubSearcherApp.swift
//  GithubSearcher
//
//  Created by nakajima on 2021/09/21.
//

import SwiftUI
import ComposableArchitecture

@main
struct GithubSearcherApp: App {
    var body: some Scene {
        WindowGroup {
            UserSearchView(
                store: Store(
                    initialState: AppState(),
                    reducer: appReducer.debug(),
                    environment: AppEnvironment()
                )
            )
        }
    }
}

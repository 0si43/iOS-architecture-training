//
//  RepositoryView.swift
//  GithubSearcher
//
//  Created by nakajima on 2021/09/21.
//

import SwiftUI

struct RepositoryView: View {
    let repositoryUrlString: String
    private let actionCreator: ActionCreator
    @StateObject var repositoryStore: RepositoryStore

    init(actionCreator: ActionCreator = ActionCreator(),
         repositoryStore: RepositoryStore = .shared,
         repositoryUrlString: String) {
        self.actionCreator = actionCreator
        _repositoryStore = StateObject(wrappedValue: repositoryStore)
        self.repositoryUrlString = repositoryUrlString
    }

    var body: some View {
        if repositoryStore.isLoading {
            ProgressView()
                .scaleEffect(x: 3, y: 3, anchor: .center)
                .onAppear {
                    actionCreator.getRepositories(urlString: repositoryUrlString)
                }
        } else {
            if repositoryStore.repositories.isEmpty {
                Text("No Repository")
            } else {
                List(repositoryStore.repositories) { repository in
                    RepositoryRow(repository: repository)
                }
            }
        }
    }
}

struct RepositoriesView_Previews: PreviewProvider {
    static var previews: some View {
        RepositoryView(repositoryUrlString: "https://api.github.com/users/0si43/repos")
    }
}

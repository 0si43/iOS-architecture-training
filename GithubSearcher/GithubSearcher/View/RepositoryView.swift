//
//  RepositoryView.swift
//  GithubSearcher
//
//  Created by nakajima on 2021/09/21.
//

import SwiftUI

struct RepositoryView: View {
    let repositoryUrlString: String
    @StateObject var presenter: RepositoryPresenter

    init(presenter: RepositoryPresenter = RepositoryPresenter(), repositoryUrlString: String) {
        _presenter = StateObject(wrappedValue: presenter)
        self.repositoryUrlString = repositoryUrlString
    }

    var body: some View {
        if let error = presenter.error {
            Text(error.localizedDescription)
        } else {
            if presenter.isLoading {
                ProgressView()
                    .scaleEffect(x: 3, y: 3, anchor: .center)
                    .onAppear {
                        presenter.loadStart(urlString: repositoryUrlString)
                    }
            } else {
                if presenter.repositories.isEmpty {
                    Text("No Repository")
                } else {
                    List(presenter.repositories) { repository in
                        RepositoryRow(repository: repository)
                    }
                }
            }
        }
    }
}

struct RepositoriesView_Previews: PreviewProvider {
    static var previews: some View {
        RepositoryView(repositoryUrlString: "https://api.github.com/users/0si43/repos")
        RepositoryView(presenter: RepositoryPresenter(
            repositories: [Repository.mock],
            isLoading: false
        ),
        repositoryUrlString: "")
        RepositoryView(presenter: RepositoryPresenter(error: .jsonParseError("invalid text")), repositoryUrlString: "")
    }
}

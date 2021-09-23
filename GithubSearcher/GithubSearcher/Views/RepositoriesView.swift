//
//  RepositoriesView.swift
//  GithubSearcher
//
//  Created by nakajima on 2021/09/21.
//

import SwiftUI

struct RepositoriesView: View {
    let repositoryUrlString: String
    @ObservedObject var model = RepositoryModel()

    var body: some View {
        if let error = model.error {
            Text(error.localizedDescription)
        } else {
            if model.isLoading {
                ProgressView()
                    .onAppear {
                        RepositoryController(model: model, urlString: repositoryUrlString).loadStart()
                    }
            } else {
                List(model.repositories) { repository in
                    Text(repository.name)
                        .padding()
                }
            }
        }
    }
}

struct RepositoriesView_Previews: PreviewProvider {
    static var previews: some View {
        RepositoriesView(repositoryUrlString: "https://api.github.com/users/0si43/repos")
    }
}

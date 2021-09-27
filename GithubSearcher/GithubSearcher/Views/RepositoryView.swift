//
//  RepositoryView.swift
//  GithubSearcher
//
//  Created by nakajima on 2021/09/21.
//

import SwiftUI

struct RepositoryView: View {
    let type: StateType
    enum StateType {
        case display([Repository])
        case error(ModelError)
    }

    var body: some View {
        switch type {
        case .display(let repositories):
            if repositories.isEmpty {
                Text("No Repository")
            } else {
                List(repositories) { repository in
                    RepositoryRow(repository: repository)
                }
            }
        case .error(let error):
            Text(error.localizedDescription)
        }
    }
}

struct RepositoryView_Previews: PreviewProvider {
    static var previews: some View {
        RepositoryView(type: .display([Repository.mock]))
        RepositoryView(type: .error(.jsonParseError("invalid text")))
    }
}

//
//  RepositoryView.swift
//  GithubSearcher
//
//  Created by nakajima on 2021/09/21.
//

import SwiftUI

//struct RepositoryView: View {
//    let repositoryUrlString: String
//    @StateObject var viewModel: RepositoryViewModel
//
//    init(viewModel: RepositoryViewModel = RepositoryViewModel(), repositoryUrlString: String) {
//        _viewModel = StateObject(wrappedValue: viewModel)
//        self.repositoryUrlString = repositoryUrlString
//    }
//
//    var body: some View {
//        if let error = viewModel.error {
//            Text(error.localizedDescription)
//        } else {
//            if viewModel.isLoading {
//                ProgressView()
//                    .scaleEffect(x: 3, y: 3, anchor: .center)
//                    .onAppear {
//                        viewModel.loadStart(urlString: repositoryUrlString)
//                    }
//            } else {
//                if viewModel.repositories.isEmpty {
//                    Text("No Repository")
//                } else {
//                    List(viewModel.repositories) { repository in
//                        RepositoryRow(repository: repository)
//                    }
//                }
//            }
//        }
//    }
//}
//
//struct RepositoriesView_Previews: PreviewProvider {
//    static var previews: some View {
//        RepositoryView(repositoryUrlString: "https://api.github.com/users/0si43/repos")
//        RepositoryView(viewModel: RepositoryViewModel(
//            repositories: [Repository.mock],
//            isLoading: false
//        ),
//        repositoryUrlString: "")
//        RepositoryView(viewModel: RepositoryViewModel(error: .jsonParseError("invalid text")), repositoryUrlString: "")
//    }
//}

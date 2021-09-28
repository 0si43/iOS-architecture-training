//
//  UserSearchView.swift
//  GithubSearcher
//
//  Created by nakajima on 2021/09/21.
//

import SwiftUI

struct UserSearchView: View {
    @State private var searchText: String = ""
    @StateObject var viewModel: UserSearchViewModel

    init(viewModel: UserSearchViewModel = UserSearchViewModel()) {
        _viewModel = StateObject(wrappedValue: viewModel)
    }

    var body: some View {
        NavigationView {
            VStack {
                TextField("user name", text: $searchText)
                    .onChange(of: searchText) { _ in
                        viewModel.loadStart(query: searchText)
                    }
                    .textFieldStyle(RoundedBorderTextFieldStyle())
                    .keyboardType(.asciiCapable)
                    .padding()
                Spacer()
                if let error = viewModel.error {
                    Text(error.localizedDescription)
                } else {
                    if viewModel.isNotFound {
                        Text("user not found")
                    } else {
                        List(viewModel.users) { user in
                            NavigationLink(destination: RepositoryView(repositoryUrlString: user.reposUrl)) {
                                UserRow(user: user)
                            }
                        }
                        .refreshable {
                            viewModel.loadStart(query: searchText)
                        }
                    }
                }
                Spacer()
            }
            .navigationTitle("🔍Search Github User")
        }
    }
}

struct UsersSearchView_Previews: PreviewProvider {
    static var previews: some View {
        UserSearchView()
        UserSearchView(viewModel: UserSearchViewModel(users: [User.mockUser]))
        UserSearchView(viewModel: UserSearchViewModel(isNotFound: true))
        UserSearchView(viewModel: UserSearchViewModel(error: .jsonParseError("invalid text")))
    }
}

//
//  UserSearchView.swift
//  GithubSearcher
//
//  Created by nakajima on 2021/09/21.
//

import SwiftUI

struct UsersSearchView: View {
    @State private var searchText: String = "0si43"
    private var users = [
        User(login: "0si43",
             avatarUrl: "https://avatars.githubusercontent.com/u/45909001?v=4",
             reposUrl: "https://api.github.com/users/0si43/repos")
    ]

    var body: some View {
        NavigationView {
            VStack {
                SearchBar(text: $searchText, placeholder: "user name")
                Spacer()
                List(users) { user in
                    NavigationLink(destination: RepositoriesView()) {
                        Text(user.login)
                            .padding()
                    }
                }
                Spacer()
            }
            .navigationTitle("Search Github User")
        }
    }
}

struct UsersSearchView_Previews: PreviewProvider {
    static var previews: some View {
        UsersSearchView()
    }
}

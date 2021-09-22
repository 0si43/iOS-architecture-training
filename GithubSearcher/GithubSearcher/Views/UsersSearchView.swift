//
//  UserSearchView.swift
//  GithubSearcher
//
//  Created by nakajima on 2021/09/21.
//

import SwiftUI

struct UsersSearchView: View {
    @State private var searchText: String = "1111"
    @ObservedObject var model = GithubModel()

    init() {
        _ = UsersController(model: model, query: searchText)
    }

    var body: some View {
        NavigationView {
            VStack {
                SearchBar(text: $searchText, placeholder: "user name")
                Spacer()
                List(model.users) { user in
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

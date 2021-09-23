//
//  UserSearchView.swift
//  GithubSearcher
//
//  Created by nakajima on 2021/09/21.
//

import SwiftUI

struct UsersSearchView: View {
    @State private var searchText: String = ""
    @ObservedObject var model = GithubModel()

    var body: some View {
        NavigationView {
            VStack {
                TextField("user name", text: $searchText)
                    .onChange(of: searchText) { _ in
                        UserController(model: model, query: searchText).loadStart()
                    }
                    .textFieldStyle(RoundedBorderTextFieldStyle())
                    .keyboardType(.asciiCapable)
                    .padding()
                Spacer()
                if let error = model.error {
                    Text(error.localizedDescription)
                } else {
                    if model.isNotFound {
                        Text("user not found")
                    } else {
                        List(model.users) { user in
                            NavigationLink(destination: RepositoriesView(repositoryUrlString: user.reposUrl)) {
                                UserRow(user: user)
                            }
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
        UsersSearchView()
    }
}

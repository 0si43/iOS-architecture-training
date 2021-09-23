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
                TextField("user name", text: $searchText,
                          onEditingChanged: { _ in
                            UsersController(model: model, query: searchText).loadStart()
                          })
                    .textFieldStyle(RoundedBorderTextFieldStyle())
                    .keyboardType(.asciiCapable)
                    .padding()
                Spacer()
                List(model.users) { user in
                    NavigationLink(destination: RepositoriesView()) {
                        Text(user.login)
                            .padding()
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

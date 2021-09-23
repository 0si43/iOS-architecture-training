//
//  UserSearchView.swift
//  GithubSearcher
//
//  Created by nakajima on 2021/09/21.
//

import SwiftUI

struct UsersSearchView: View {
    @State private var searchText: String = ""
    @ObservedObject var model = UserModel()

    var body: some View {
        NavigationView {
            VStack {
                TextField("user name", text: $searchText)
                    .onChange(of: searchText) { _ in
                        UsersController(model: model, query: searchText).loadStart()
                    }
                    .textFieldStyle(RoundedBorderTextFieldStyle())
                    .keyboardType(.asciiCapable)
                    .padding()
                Spacer()
                if let error = model.error {
                    errorView(error: error)
                } else {
                    if model.isNotFound {
                        Text("user not found")
                    } else {
                        List(model.users) { user in
                            NavigationLink(destination: RepositoriesView()) {
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

    private func errorView(error: ModelError) -> Text {
        return Text(error.localizedDescription)
    }
}

struct UsersSearchView_Previews: PreviewProvider {
    static var previews: some View {
        UsersSearchView()
    }
}

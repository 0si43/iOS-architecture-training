//
//  UserSearchView.swift
//  GithubSearcher
//
//  Created by nakajima on 2021/09/21.
//

import SwiftUI

struct UserSearchView: View {
    @State private var searchText: String = ""
    private let actionCreator: ActionCreator
    @StateObject var userSearchStore: UserSearchStore

    init(actionCreator: ActionCreator = ActionCreator(),
         userSearchStore: UserSearchStore = .shared) {
        self.actionCreator = actionCreator
        _userSearchStore = StateObject(wrappedValue: userSearchStore)
    }

    var body: some View {
        NavigationView {
            VStack {
                TextField("user name", text: $searchText)
                    .onChange(of: searchText) { _ in
                        actionCreator.searchUser(query: searchText)
                    }
                    .textFieldStyle(RoundedBorderTextFieldStyle())
                    .keyboardType(.asciiCapable)
                    .padding()
                Spacer()
                List(userSearchStore.users) { user in
                    //                        NavigationLink(destination: RepositoryView(repositoryUrlString: user.reposUrl)) {
                    NavigationLink(destination: Text("temp")) {
                        UserRow(user: user)
                    }
                }
                .refreshable {
                    actionCreator.searchUser(query: searchText)
                }
            }
            .navigationTitle("🔍Search Github User")
        }
    }
}

struct UsersSearchView_Previews: PreviewProvider {
    static var previews: some View {
        UserSearchView()
    }
}

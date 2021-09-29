//
//  UserSearchView.swift
//  GithubSearcher
//
//  Created by nakajima on 2021/09/21.
//

import SwiftUI

struct UserSearchView: View {
    @State private var searchText: String = ""
    @StateObject var presenter: UserSearchPresenter

    init(presenter: UserSearchPresenter = UserSearchPresenter()) {
        _presenter = StateObject(wrappedValue: presenter)
    }

    var body: some View {
        NavigationView {
            VStack {
                TextField("user name", text: $searchText)
                    .onChange(of: searchText) { _ in
                        presenter.loadStart(query: searchText)
                    }
                    .textFieldStyle(RoundedBorderTextFieldStyle())
                    .keyboardType(.asciiCapable)
                    .padding()
                Spacer()
                if let error = presenter.error {
                    Text(error.localizedDescription)
                } else {
                    if presenter.isNotFound {
                        Text("user not found")
                    } else {
                        List(presenter.users) { user in
                            presenter.router.navigationLink(user: user)
                        }
                        .refreshable {
                            presenter.loadStart(query: searchText)
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
        UserSearchView(presenter: UserSearchPresenter(users: [User.mockUser]))
        UserSearchView(presenter: UserSearchPresenter(isNotFound: true))
        UserSearchView(presenter: UserSearchPresenter(error: .jsonParseError("invalid text")))
    }
}

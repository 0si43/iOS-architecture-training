//
//  UserSearchView.swift
//  GithubSearcher
//
//  Created by nakajima on 2021/09/21.
//

import SwiftUI
import ComposableArchitecture

struct AppEnvironment { }

struct AppState: Equatable {
    var users = [User]()
    var searchQuery: String = ""
}

enum AppAction: Equatable {
    case searchQueryEditing(String)
    case response(Result<[User], ModelError>)
}

let appReducer = Reducer<AppState, AppAction, AppEnvironment> { state, action, _ in
    switch action {
    case .searchQueryEditing(let query):
        return .none
    case .response(let result):
        switch result {
        case .success(let users):
            state.users = users
            return .none
        case .failure(let error):
            print(error.localizedDescription)
            return .none
        }
    }
}

struct UserSearchView: View {
    let store: Store<AppState, AppAction>

    var body: some View {
        WithViewStore(self.store) { viewStore in
            NavigationView {
                VStack {
                    TextField("user name",
                              text: viewStore.binding(
                                get: \.searchQuery, send: AppAction.searchQueryEditing
                              )
                    )
                    .onChange(of: viewStore.searchQuery) { _ in
                        viewStore.send(.searchQueryEditing(viewStore.searchQuery))
                    }
                    .textFieldStyle(RoundedBorderTextFieldStyle())
                    .keyboardType(.asciiCapable)
                    .padding()
                    Spacer()
                    List(viewStore.users) { user in
                        NavigationLink(destination: Text(":TODO")) {
                            UserRow(user: user)
                        }
                    }
                    .refreshable {
                        viewStore.send(.searchQueryEditing(viewStore.searchQuery))
                    }
                }
                .navigationTitle("🔍Search Github User")
            }
        }
    }
}

//struct UsersSearchView_Previews: PreviewProvider {
//    static var previews: some View {
//        UserSearchView(store: Store())
//    }
//}

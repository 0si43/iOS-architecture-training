//
//  UserSearchView.swift
//  GithubSearcher
//
//  Created by nakajima on 2021/09/21.
//

import SwiftUI
import ComposableArchitecture

struct AppEnvironment {
    var githubApi = GithubApi.live
    var mainQueue: AnySchedulerOf<DispatchQueue> = .main
}

struct AppState: Equatable {
    var users = [User]()
    var searchQuery: String = ""
}

enum AppAction: Equatable {
    case searchQueryEditing(String)
    case response(Result<[User], ModelError>)
}

let appReducer = Reducer<AppState, AppAction, AppEnvironment> { state, action, environment in
    switch action {
    case let .searchQueryEditing(query):
        struct SearchUserId: Hashable {}

        return environment.githubApi
            .users(query)
            .receive(on: environment.mainQueue)
            .catchToEffect(AppAction.response)
            .cancellable(id: SearchUserId(), cancelInFlight: true)
    case let .response(.success(users)):
        state.users = users
        return .none
    case let .response(.failure(error)):
        print(error)
        return .none
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

struct UsersSearchView_Previews: PreviewProvider {
    static var previews: some View {
        UserSearchView(
            store: Store(
                initialState: AppState(users: [User.mockUser], searchQuery: ""),
                reducer: appReducer,
                environment: AppEnvironment()
            )
        )
    }
}

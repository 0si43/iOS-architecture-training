//
//  UserSearchRouter.swift
//  GithubSearcher
//
//  Created by nakajima on 2021/09/22.
//

import SwiftUI

/// ユーザー検索のRouter
struct UserSearchRouter {
    func navigationLink(user: User) -> some View {
        return NavigationLink(destination: RepositoryView(repositoryUrlString: user.reposUrl)) {
            UserRow(user: user)
        }
    }
}

struct UserSearchRouter_Previews: PreviewProvider {
    static var previews: some View {
        UserSearchRouter().navigationLink(user: User.mockUser)
    }
}

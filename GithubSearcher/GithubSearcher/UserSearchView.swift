//
//  UserSearchView.swift
//  GithubSearcher
//
//  Created by nakajima on 2021/09/21.
//

import SwiftUI

struct UserSearchView: View {
    @State private var searchText: String = "0si43"

    var body: some View {
        NavigationView {
            VStack {
                SearchBar(text: $searchText, placeholder: "user name")
                Spacer()
                List {
                    NavigationLink(destination: RepositoriesView()) {
                        Text(searchText)
                            .padding()
                    }
                }
                Spacer()
            }
            .navigationTitle("Search Github User")
        }
    }
}

struct UserSearchView_Previews: PreviewProvider {
    static var previews: some View {
        UserSearchView()
    }
}

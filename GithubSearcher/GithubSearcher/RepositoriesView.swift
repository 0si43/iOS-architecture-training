//
//  RepositoriesView.swift
//  GithubSearcher
//
//  Created by nakajima on 2021/09/21.
//

import SwiftUI

struct RepositoriesView: View {
    var body: some View {
        VStack {
            List {
                Text("repo name")
                    .padding()
            }

        }
    }
}

struct RepositoriesView_Previews: PreviewProvider {
    static var previews: some View {
        RepositoriesView()
    }
}

//
//  ContentView.swift
//  GithubSearcher
//
//  Created by nakajima on 2021/09/21.
//

import SwiftUI

struct ContentView: View {
    @State private var searchText: String = "test"

    var body: some View {
        NavigationView {
            VStack {
                SearchBar(text: $searchText, placeholder: "user name")
                Spacer()
                List {
                    Text(searchText)
                        .padding()
                }
                Spacer()
            }
            .navigationTitle("Search Github User")
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}

//
//  SearchBar.swift
//  GithubSearcher
//
//  Created by nakajima on 2021/09/22.
//

import SwiftUI

/// UISearchBarをSwiftUIへブリッジする
/// https://dasuko.hatenadiary.jp/entry/2021/03/02/173000
struct SearchBar: UIViewRepresentable {
    @Binding var text: String
    var placeholder: String
    var searchBarStyle = UISearchBar.Style.minimal
    var autocapitalizationType = UITextAutocapitalizationType.none

    func makeCoordinator() -> SearchBar.Coordinator {
        return Coordinator(text: $text)
    }

    func makeUIView(context: UIViewRepresentableContext<SearchBar>) -> UISearchBar {
        let searchBar = UISearchBar(frame: .zero)
        searchBar.delegate = context.coordinator
        searchBar.searchBarStyle  = searchBarStyle
        searchBar.autocapitalizationType = autocapitalizationType
        searchBar.placeholder = placeholder
        return searchBar
    }

    func updateUIView(_ uiView: UISearchBar, context: UIViewRepresentableContext<SearchBar>) {
        uiView.text = text
    }

    class Coordinator: NSObject, UISearchBarDelegate {
        @Binding var text: String

        init(text: Binding<String>) {
            _text = text
        }

        func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
            text = searchText
        }
    }
}

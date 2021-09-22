//
//  GithubModel.swift
//  GithubSearcher
//
//  Created by nakajima on 2021/09/22.
//

import Foundation

enum ModelError: Error {
    case encodingError
    case urlError
    //    case APIError(Error)
}

class GithubModel: ObservableObject {
    private let urlString = "https://api.github.com/search/users?q="
    @Published var users = [User]() {
        didSet {
            print(users)
        }
    }

    init() {

    }

    public func fetch(query: String) throws {
        guard let encodedQuery = query.addingPercentEncoding(withAllowedCharacters: .urlPathAllowed) else {
            throw ModelError.encodingError
        }
        guard let url = URL(string: urlString + encodedQuery) else {
            throw ModelError.urlError
        }

        URLSession.shared.dataTask(with: url) {(data, _, error) in
            guard let data = data else { return }
            do {
                let users = try JSONDecoder().decode(Users.self, from: data)
                DispatchQueue.main.async {
                    self.users = users.items
                }
            } catch {
                print("json convert failed in JSONDecoder. " + error.localizedDescription)
            }
        }.resume()
    }
}

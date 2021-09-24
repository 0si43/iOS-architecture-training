//
//  ViewController.swift
//  GithubSearcher
//
//  Created by nakajima on 2021/09/24.
//

import UIKit
import SwiftUI

protocol ViewProtocol: AnyObject {
    func loadUser(query: String)
    func loadReository(urlString: String)
}

class ViewController: UIViewController {
    private let model = GithubModel()

    override func viewDidLoad() {
        super.viewDidLoad()
        let newViewController = UIHostingController(rootView: UsersSearchView(delegate: self, model: model))

        newViewController.view.translatesAutoresizingMaskIntoConstraints = false
        newViewController.view.heightAnchor.constraint(equalToConstant: UIScreen.main.bounds.height).isActive = true
        newViewController.view.widthAnchor.constraint(equalToConstant: UIScreen.main.bounds.width).isActive = true

        view.addSubview(newViewController.view)
    }
}

extension ViewController: ViewProtocol {
    func loadUser(query: String) {
        model.fetchUser(query: query)
    }

    func loadReository(urlString: String) {
        model.fetchRepositories(urlString: urlString)
    }
}

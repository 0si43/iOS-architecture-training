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
    private var userSearchView: UsersSearchView!
    private var hostingController: UIHostingController<UsersSearchView>!

    override func viewDidLoad() {
        super.viewDidLoad()
        userSearchView = UsersSearchView(delegate: self, type: .display([User]()))
        hostingController = UIHostingController(rootView: userSearchView)

        hostingController.view.translatesAutoresizingMaskIntoConstraints = false
        hostingController.view.heightAnchor.constraint(equalToConstant: UIScreen.main.bounds.height).isActive = true
        hostingController.view.widthAnchor.constraint(equalToConstant: UIScreen.main.bounds.width).isActive = true

        view.addSubview(hostingController.view)
    }
}

extension ViewController: ViewProtocol {
    func loadUser(query: String) {
        model.fetchUser(query: query) { [weak self] _ in
            print("temp")
        }
    }

    func loadReository(urlString: String) {
        model.fetchRepositories(urlString: urlString)
    }
}

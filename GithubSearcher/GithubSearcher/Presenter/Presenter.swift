//
//  Presenter.swift
//  GithubSearcher
//
//  Created by nakajima on 2021/09/24.
//

import UIKit
import SwiftUI

/// Presenterからの出力を受けとるクラスが準拠する
protocol PresenterOutput: AnyObject {
    func loadUser(query: String)
    func transitionToRepository(repositoryUrlString: String) -> RepositoryView
}

class Presenter: UIViewController {
    private var userSearchView: UserSearchView!
    private var hostingController: UIHostingController<UserSearchView>!
    private var model: SearchUserModelInput!
    private var progressViewAsUIView: UIView {
        let progressView = ProgressView().scaleEffect(x: 3, y: 3, anchor: .center)
        let controller = UIHostingController(rootView: progressView)
        controller.view.translatesAutoresizingMaskIntoConstraints = false
        controller.view.heightAnchor.constraint(equalToConstant: UIScreen.main.bounds.height).isActive = true
        controller.view.widthAnchor.constraint(equalToConstant: UIScreen.main.bounds.width).isActive = true
        return controller.view
    }
    private var repositoryView: RepositoryView!

    public func inject(view: UserSearchView, model: SearchUserModelInput) {
        self.userSearchView = view
        self.model = model
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        guard model != nil, userSearchView != nil else {
            print("PresenterにModelとViewを指定してください")
            return
        }

        hostingController = UIHostingController(rootView: userSearchView)
        hostingController.view.translatesAutoresizingMaskIntoConstraints = false
        hostingController.view.heightAnchor.constraint(equalToConstant: UIScreen.main.bounds.height).isActive = true
        hostingController.view.widthAnchor.constraint(equalToConstant: UIScreen.main.bounds.width).isActive = true
        view.addSubview(hostingController.view)
    }
}

extension Presenter: PresenterOutput {
    func loadUser(query: String) {
        guard !query.isEmpty else { return }

        model.fetchUser(query: query) { [weak self] result in
            guard let self = self else { return }
            switch result {
            case .success(let users):
                if users.isEmpty {
                    self.userSearchView = UserSearchView(delegate: self, type: .notFound)
                } else {
                    self.userSearchView = UserSearchView(delegate: self, type: .display(users))
                }
            case .failure(let error):
                self.userSearchView = UserSearchView(delegate: self, type: .error(error))
            }
            self.hostingController.rootView = self.userSearchView
        }
    }

    /// FIXME: 結果を受け取っても、Viewは更新されないので、画面遷移をまるごと書く必要があった
    func transitionToRepository(repositoryUrlString: String) -> RepositoryView {
        repositoryView = RepositoryView(type: .loading)

        model.fetchRepository(urlString: repositoryUrlString) { [weak self] result in
            switch result {
            case .success(let repositories):
                self?.repositoryView = RepositoryView(type: .display(repositories))
            case .failure(let error):
                self?.repositoryView =  RepositoryView(type: .error(error))
            }
        }
        return repositoryView
    }
}

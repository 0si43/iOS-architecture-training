//
//  SceneDelegate.swift
//  GithubSearcher
//
//  Created by nakajima on 2021/09/24.
//

import UIKit

class SceneDelegate: UIResponder, UIWindowSceneDelegate {

    var window: UIWindow?

    func scene(_ scene: UIScene, willConnectTo session: UISceneSession, options connectionOptions: UIScene.ConnectionOptions) {
        guard let windowScene = (scene as? UIWindowScene) else { return }

        let presenter = Presenter()
        let view = UserSearchView(delegate: presenter, type: .display([User]()))
        let model = GithubModel()
        presenter.inject(view: view, model: model)

        window = UIWindow(windowScene: windowScene)
        window?.rootViewController = presenter
        window?.makeKeyAndVisible()
    }
}

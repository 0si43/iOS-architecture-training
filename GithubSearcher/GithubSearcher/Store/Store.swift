//
//  Store.swift
//  GithubSearcher
//
//  Created by nakajima on 2021/09/28.
//

import Foundation

class Store {
    private lazy var dispatchToken: DispatchToken = {
        return dispatcher.register(callback: { [weak self] action in
            self?.onDispatch(action)
        })
    }()

    private let dispatcher: Dispatcher

    deinit {
        dispatcher.unregister(dispatchToken)
    }

    init(dispatcher: Dispatcher) {
        self.dispatcher = dispatcher
        _ = dispatchToken
    }

    func onDispatch(_ action: Action) {
        fatalError("must override")
    }
}

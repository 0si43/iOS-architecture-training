//
//  RepositoryViewModel.swift
//  GithubSearcher
//
//  Created by nakajima on 2021/09/22.
//

import Combine

/// リポジトリ一覧のViewModel
class RepositoryViewModel: ObservableObject {
    //    let model: ModelInput
    //    @Published var repositories: [Repository]
    //    @Published var isLoading: Bool
    //    @Published var error: ModelError?
    //
    //    init(model: ModelInput = GithubModel(),
    //         repositories: [Repository] = [Repository](), isLoading: Bool = true, error: ModelError? = nil) {
    //        self.model = model
    //        self.repositories = repositories
    //        self.isLoading = isLoading
    //        self.error = error
    //    }
    //
    //    /// Modelにロード開始を要求する
    //    func loadStart(urlString: String) {
    //        repositories = [Repository]()
    //        isLoading = true
    //        error = nil
    //
    //        model.fetchRepository(urlString: urlString) { [weak self] result in
    //            switch result {
    //            case .success(let repositories):
    //                self?.repositories = repositories
    //            case .failure(let error):
    //                self?.error = error
    //            }
    //            self?.isLoading = false
    //        }
    //    }

}

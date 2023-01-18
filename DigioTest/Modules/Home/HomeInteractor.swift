//
//  HomeInteractor.swift
//  DigioTest
//
//  Created by Pedro Freddi on 13/01/23.
//

import Foundation

protocol HomeBusinessLogic {
    func requestHomeContent()
    func showLoading()
}

class HomeInteractor: HomeBusinessLogic {
    var presenter: HomePresentationLogic?
    var homeWorker: HomeWorkerLogic?

    func requestHomeContent() {
        showLoading()
        homeWorker?.requestContent(completion: {[weak self] response in
            switch response {
            case .success(let success):
                self?.presenter?.presentContent(response: Home.Content.Response(content: success))
            case .failure(let failure):
                self?.presenter?.presentFailure(response: Home.Content.ViewModelFailure(errorMessage: failure.localizedDescription))
            }
        })
    }

    func showLoading() {
        presenter?.presentLoading()
    }
}

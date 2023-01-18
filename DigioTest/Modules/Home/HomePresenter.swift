//
//  HomePresenter.swift
//  DigioTest
//
//  Created by Pedro Freddi on 13/01/23.
//

import Foundation
import UIKit

protocol HomePresentationLogic {
    func presentContent(response: Home.Content.Response)
    func presentFailure(response: Home.Content.ViewModelFailure)
    func presentLoading()
}

class HomePresenter: HomePresentationLogic {
    weak var viewController: HomeDisplayLogic?

    func presentContent(response: Home.Content.Response) {
        viewController?.displayContent(viewModel: Home.Content.ViewModelSuccess(banners: response.content.toArray()))
    }
    
    func presentFailure(response: Home.Content.ViewModelFailure) {
        viewController?.displayContentFailure(viewModel: response)
    }

    func presentLoading() {
        viewController?.displayContentLoading()
    }
}

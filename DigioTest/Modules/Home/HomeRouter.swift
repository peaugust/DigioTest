//
//  HomeRouter.swift
//  DigioTest
//
//  Created by Pedro Freddi on 13/01/23.
//

import UIKit

protocol HomeRouterLogic: AnyObject {
    func presentScreenFrom(_ banner: Banner)
}

class HomeRouter: HomeRouterLogic {
    weak var navigationViewController: UINavigationController?

    func presentScreenFrom(_ banner: Banner) {
        let vc = UIViewController()
        vc.view.backgroundColor = UIColor(red: CGFloat(arc4random_uniform(255)) / 255.0, green: CGFloat(arc4random_uniform(255)) / 255.0, blue: CGFloat(arc4random_uniform(255)) / 255.0, alpha: 1)
        navigationViewController?.present(vc, animated: true)
    }
}

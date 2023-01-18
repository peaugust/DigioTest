//
//  AppDelegate.swift
//  DigioTest
//
//  Created by Pedro Freddi on 13/01/23.
//

import UIKit

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {
    var window: UIWindow?

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {

        self.window = UIWindow(frame: UIScreen.main.bounds)
        window?.rootViewController = UIStoryboard(name: "Home", bundle: nil).instantiateInitialViewController()
        window?.makeKeyAndVisible()
        return true
    }
}

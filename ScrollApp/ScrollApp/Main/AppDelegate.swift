//
//  AppDelegate.swift
//  ScrollApp
//
//  Created by Wilmer Barrios on 12/05/21.
//

import UIKit

@main
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        window = UIWindow(frame: UIScreen.main.bounds)
//        window?.rootViewController = HomeUIFactory.makeHomeController()
        window?.rootViewController = ScrollViewOneController()
        window?.makeKeyAndVisible()
        return true
    }
}


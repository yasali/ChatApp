//
//  AppDelegate.swift
//  ChatApp
//
//  Created by SWE-PC-110 on 2021-08-10.
//

import UIKit

@main
class AppDelegate: UIResponder, UIApplicationDelegate {
    var window: UIWindow?
    private lazy var navigationController = UINavigationController()

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        startChatApp()
        return true
    }
    
    private func startChatApp() {
        // TBD implement routing in Seperate Router, handles all navigation
        let nav = UINavigationController(rootViewController: HomeController())
        window?.rootViewController = nav
        window?.makeKeyAndVisible()
    }
}


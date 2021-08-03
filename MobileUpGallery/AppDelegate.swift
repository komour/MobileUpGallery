//
//  AppDelegate.swift
//  MobileUpGallery
//
//  Created by Andrey Komarov on 8/2/21.
//

import UIKit

@main
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        window = UIWindow.init(frame: UIScreen.main.bounds)
        window?.rootViewController = StartVC()
        window?.makeKeyAndVisible()
        return true
    }
}


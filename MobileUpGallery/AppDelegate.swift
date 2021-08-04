//
//  AppDelegate.swift
//  MobileUpGallery
//
//  Created by Andrey Komarov on 8/2/21.
//

import UIKit
import SwiftyVK

@main
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?
    var vkDelegateReference : SwiftyVKDelegate?

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        vkDelegateReference = VKDelegate()
        
        window = UIWindow.init(frame: UIScreen.main.bounds)
        window?.rootViewController = StartViewController()
        window?.makeKeyAndVisible()
        return true
    }
}


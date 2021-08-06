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
    var vkDelegateReference: SwiftyVKDelegate?

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        vkDelegateReference = VKDelegate()
        window = UIWindow(frame: UIScreen.main.bounds)
        
        let startVC = StartViewController()
        window?.rootViewController = startVC
        window?.makeKeyAndVisible()
        
        if VK.sessions.default.state == SessionState.authorized {
//            TODO duplicated code
            let navigationController = UINavigationController()
            navigationController.setViewControllers([GalleryViewController()], animated: false)
            navigationController.modalPresentationStyle = .fullScreen
            startVC.present(navigationController, animated: true, completion: nil)
        }
        return true
    }
}

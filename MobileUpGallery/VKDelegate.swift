//
//  VKDelegate.swift
//  MobileUpGallery
//
//  Created by Andrey Komarov on 8/4/21.
//

import Foundation
import SwiftyVK

final class VKDelegate: SwiftyVKDelegate {
    private let appId = "7918495"
    private let scopes: Scopes = []

    init() {
        VK.setUp(appId: appId, delegate: self)
        VK.sessions.default.config.attemptTimeout = 5
    }

    func vkNeedsScopes(for sessionId: String) -> Scopes {
        return scopes
    }

    func vkNeedToPresent(viewController: VKViewController) {
        let keyWindow = UIApplication.shared.windows.filter { $0.isKeyWindow }.first
        if var topController = keyWindow?.rootViewController {
            while let presentedViewController = topController.presentedViewController {
                topController = presentedViewController
            }
            topController.present(viewController, animated: true, completion: nil)
        }
    }

    func vkTokenCreated(for sessionId: String, info: [String: String]) {
        print("token created in session \(sessionId) with info \(info)")
    }

    func vkTokenUpdated(for sessionId: String, info: [String: String]) {
        print("token updated in session \(sessionId) with info \(info)")
    }

    func vkTokenRemoved(for sessionId: String) {
        print("token removed in session \(sessionId)")
    }
}

//
//  StartViewController.swift
//  MobileUpGallery
//
//  Created by Andrey Komarov on 8/2/21.
//

import SwiftyVK
import UIKit

class StartViewController: UIViewController {
    // MARK: - Subviews

    @IBOutlet private var authButton: UIButton!

    // MARK: - Lifecycle

    override func viewDidLoad() {
        super.viewDidLoad()
        setUpAuthButton()
    }

    // MARK: - Private methods

    private func presentNetworkErrorAlert() {
        let alert = UIAlertController(title: LocalizedStrings.networkError,
                                      message: LocalizedStrings.checkAndRetry,
                                      preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "Ок", style: .default, handler: { _ in
            alert.dismiss(animated: true, completion: nil)
        }))
        present(alert, animated: true, completion: nil)
    }

    private func setUpAuthButton() {
        authButton.layer.cornerRadius = 12
        authButton.setTitle(LocalizedStrings.enterViaVK, for: .normal)
    }

    // MARK: - UI Actions

    @IBAction private func authButtonAction() {
        VK.sessions.default.logIn(
            onSuccess: { info in
                DispatchQueue.main.async {
                    let navigationController = UINavigationController()
                    navigationController.setViewControllers([GalleryViewController()], animated: false)
                    navigationController.modalPresentationStyle = .fullScreen
                    self.present(navigationController, animated: true, completion: nil)
                }
                print("SwiftyVK: success authorize with \(info)")
            },
            onError: { error in
                if case VKError.authorizationCancelled = error {
                } else {
                    print("SwiftyVK: authorize failed with \(error)")
                    DispatchQueue.main.async {
                        self.presentNetworkErrorAlert()
                    }
                }
            }
        )
    }
}

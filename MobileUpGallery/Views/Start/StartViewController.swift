//
//  ViewController.swift
//  MobileUpGallery
//
//  Created by Andrey Komarov on 8/2/21.
//

import UIKit
import SwiftyVK

class StartViewController: UIViewController {

    @IBOutlet weak var authButton: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setUpAuthButton()
    }
    
    func setUpAuthButton() {
        authButton.layer.cornerRadius = 12
    }

    @IBAction func authButtonAction() {
        VK.sessions.default.logIn(
            onSuccess: { info in
                DispatchQueue.main.async {
                    let navigationController = UINavigationController()
                    navigationController.setViewControllers([GalleryViewController()], animated: false)
                    navigationController.modalPresentationStyle = .fullScreen
                    self.present(navigationController, animated: true, completion: nil)
                }
                print("SwiftyVK: success authorize with", info)
            },
            onError: { error in
                print("SwiftyVK: authorize failed with", error)
                DispatchQueue.main.async {
                    self.presentNetworkErrorAlert()
                }
            }
        )
    }
    
    func presentNetworkErrorAlert() {
        let alert = UIAlertController(title: "Ошибка сети",
                                      message: "Проверьте свое интернет-соединение и попробуйте снова.",
                                      preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "Ок", style: .default, handler: { _ in
            alert.dismiss(animated: true, completion: nil)
        }))
        self.present(alert, animated: true, completion: nil)
    }
}

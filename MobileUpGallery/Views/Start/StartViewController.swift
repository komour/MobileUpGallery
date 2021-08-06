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
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
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
            }
        )
    }
    
}

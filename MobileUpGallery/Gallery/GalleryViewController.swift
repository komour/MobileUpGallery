//
//  GalleryViewController.swift
//  MobileUpGallery
//
//  Created by Andrey Komarov on 8/5/21.
//

import UIKit

class GalleryViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = "Mobile Up Gallery"
        let logoutButton = UIBarButtonItem(title: "Выход", style: .plain, target: self, action: #selector(doLogout))
        logoutButton.tintColor = .black
        logoutButton.setTitleTextAttributes([NSAttributedString.Key.font: UIFont.systemFont(ofSize: 17, weight: .medium)], for: .normal)

        self.navigationItem.rightBarButtonItem  = logoutButton
    }
    
    @objc func doLogout(sender: UIButton!) {
        dismiss(animated: true, completion: nil)
    }
}

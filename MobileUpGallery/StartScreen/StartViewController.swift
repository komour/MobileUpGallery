//
//  ViewController.swift
//  MobileUpGallery
//
//  Created by Andrey Komarov on 8/2/21.
//

import UIKit

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
        print(#function)
    }
    
}


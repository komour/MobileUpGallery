//
//  ViewController.swift
//  MobileUpGallery
//
//  Created by Andrey Komarov on 8/2/21.
//

import UIKit

class StartVC: UIViewController {

    @IBOutlet weak var authButton: UIButton!
    override func viewDidLoad() {
        super.viewDidLoad()
        print(#function)
        // Do any additional setup after loading the view.
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
//        authButton.layer.cornerRadius = 10
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        print(#function)
    }

    @IBAction func authButtonAction() {
        print(#function)
    }
    
}


//
//  ShowPhotoViewController.swift
//  MobileUpGallery
//
//  Created by Andrey Komarov on 8/5/21.
//

import UIKit

class ShowPhotoViewController: UIViewController {

    @IBOutlet weak var imageView: UIImageView!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        self.title = "Date"
        
//        share button setting
        let shareButton = UIBarButtonItem(image: #imageLiteral(resourceName: "share-button"), style: .plain, target: self, action: #selector(doShare))
        shareButton.tintColor = .black
        self.navigationItem.rightBarButtonItem = shareButton
        
//        image view setting
        imageView.image = #imageLiteral(resourceName: "placeholder")
    }
    
    @objc func doShare() {
//        TODO
    }
}

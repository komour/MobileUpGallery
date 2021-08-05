//
//  ShowPhotoViewController.swift
//  MobileUpGallery
//
//  Created by Andrey Komarov on 8/5/21.
//

import UIKit

class ShowPhotoViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        self.title = "Date"
        
//        share button setting
        let shareButton = UIBarButtonItem(barButtonSystemItem: .action, target: self, action: #selector(doShare))
        shareButton.tintColor = .black
        self.navigationItem.rightBarButtonItem = shareButton
        
//        image view setting
        let imageView = UIImageView(frame: .zero)
        view.addSubview(imageView)
        imageView.image = #imageLiteral(resourceName: "placeholder")
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.addConstraint(NSLayoutConstraint(item: imageView, attribute: .height, relatedBy: .equal, toItem: imageView, attribute: .width, multiplier: 1, constant: 0))
        NSLayoutConstraint.activate([
            imageView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            imageView.centerYAnchor.constraint(equalTo: view.centerYAnchor),
            imageView.widthAnchor.constraint(equalTo: view.widthAnchor)
        ])
    }
    
    @objc func doShare() {
//        TODO
    }
}

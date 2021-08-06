//
//  ShowPhotoViewController.swift
//  MobileUpGallery
//
//  Created by Andrey Komarov on 8/5/21.
//

import Kingfisher
import UIKit

class ShowPhotoViewController: UIViewController {
    @IBOutlet var imageView: UIImageView!
    var photoUrl: String?
    var date: Double?

    override func viewDidLoad() {
        super.viewDidLoad()

        setUpShareButton()
        setUpImageView()
        setUpTitle()
    }

    func setUpShareButton() {
        let shareButton = UIBarButtonItem(image: #imageLiteral(resourceName: "share-button"), style: .plain, target: self, action: #selector(doShare))
        shareButton.tintColor = .black
        navigationItem.rightBarButtonItem = shareButton
    }

    func setUpImageView() {
        imageView.image = #imageLiteral(resourceName: "placeholder")
        if let photoUrl = photoUrl, let photoUrl = URL(string: photoUrl) {
            imageView.kf.setImage(with: photoUrl)
        }
    }

    func setUpTitle() {
        if let date = date {
            let date = Date(timeIntervalSince1970: date)
            let formater = DateFormatter()
            formater.dateFormat = "MMM dd, yyyy"
            title = formater.string(from: date)
        } else {
            title = "nil"
            print("nil date in \(#function)")
        }
    }

    @objc func doShare() {
        guard let image = imageView.image else {
            fatalError("nil image in \(#function)")
        }
        presentShareMenu(image: image)
    }

    func presentShareMenu(image: UIImage) {
        let activityViewController = UIActivityViewController(activityItems: [image], applicationActivities: nil)
        activityViewController.completionWithItemsHandler = { activity, success, _, _ in
            if activity == .saveToCameraRoll && success == true {
                self.presentSuccessAlert()
            }
        }
        present(activityViewController, animated: true, completion: nil)
    }

    func presentSuccessAlert() {
        let alert = UIAlertController(title: nil, message: LocalizedStrings.successSave, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: LocalizedStrings.ok, style: .default, handler: { _ in
            alert.dismiss(animated: true, completion: nil)
        }))
        present(alert, animated: true, completion: nil)
    }
}

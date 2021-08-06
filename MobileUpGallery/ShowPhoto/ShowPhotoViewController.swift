//
//  ShowPhotoViewController.swift
//  MobileUpGallery
//
//  Created by Andrey Komarov on 8/5/21.
//

import UIKit

class ShowPhotoViewController: UIViewController {
    
    @IBOutlet weak var imageView: UIImageView!
    var photoUrl: String?
    var date: Double?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
//        share button setting
        let shareButton = UIBarButtonItem(image: #imageLiteral(resourceName: "share-button"), style: .plain, target: self, action: #selector(doShare))
        shareButton.tintColor = .black
        self.navigationItem.rightBarButtonItem = shareButton
        
//        image view setting
        if let photoUrl = photoUrl {
            imageView.loadImageUsingUrlString(urlString: photoUrl)
        } else {
            imageView.image = #imageLiteral(resourceName: "placeholder")
        }
        
//        title setting
        setTitle()
    }
    
    func setTitle() {
        if let date = date {
            let date = Date(timeIntervalSince1970: date)
            let formater = DateFormatter()
            formater.dateFormat = "MMM dd, yyyy"
            self.title = formater.string(from: date)
        } else {
            self.title = "SEP 07, 2007"
            print("nil date in \(#function)")
        }
    }
    
    @objc func doShare() {
        guard let image = imageView.image else {
            print("nil image in \(#function)")
            return
        }
        let activityViewController = UIActivityViewController(activityItems: [image], applicationActivities: nil)
        activityViewController.completionWithItemsHandler = { activity, success, items, error in
            if activity == .saveToCameraRoll && success == true {
                let alert = UIAlertController(title: nil, message: "Изображение успешно сохранено.", preferredStyle: .alert)
                alert.addAction(UIAlertAction(title: "Ок", style: .default, handler: { _ in
                    alert.dismiss(animated: true, completion: nil)
                }))
                self.present(alert, animated: true, completion: nil)
            }
        }
        self.present(activityViewController, animated: true, completion: nil)
    }
}
